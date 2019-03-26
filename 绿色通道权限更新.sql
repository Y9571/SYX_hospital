--该sql用于更新用户的绿色通道权限,名单由医院人员提供

INSERT INTO BD_OU_USER_ROLE
SELECT
  replace(sys_guid(), '-', '') PK_USERROLE,
  'a41476368e2943f48c32d0cb1179dab8' PK_ORG,
  PK_USER,
  case when ROLENAME = '住院医生' then '1dfc498ff74c44e4bc2481d8fc2ab3ce' else '948ba049f0c14b578e133444cb48fc42' end PK_ROLE,
  null CREATOR,
  null CREATE_TIME,
  null MODIFIER,
  null MODITY_TIME,
  '0' DEL_FLAG,
  null TS
FROM (SELECT DISTINCT userr.CODE_USER,userr.NAME_USER,userr.PK_USER,ROLENAME from BD_OU_USER userr
  INNER JOIN (SELECT DISTINCT CODE,NAME,ROLENAME from a_bd_pd_jz) jz on jz.CODE = userr.CODE_USER
  INNER JOIN BD_OU_USER_ROLE urole on userr.PK_USER = urole.PK_USER and DEL_FLAG = 0
WHERE userr.CODE_USER NOT IN (SELECT DISTINCT userr.CODE_USER from BD_OU_USER userr
  INNER JOIN (SELECT DISTINCT CODE,NAME,ROLENAME from a_bd_pd_jz) jz on jz.CODE = userr.CODE_USER
  INNER JOIN BD_OU_USER_ROLE urole on userr.PK_USER = urole.PK_USER and DEL_FLAG = 0
where  exists(SELECT role.PK_ROLE,NAME_ROLE from BD_OU_ROLE_OPER oper
  INNER JOIN (SELECT * from BD_OU_MENU where NAME_MENU like '%绿色通道%') menu on menu.PK_MENU = oper.PK_MENU
  INNER JOIN BD_OU_ROLE role on role.PK_ROLE = oper.PK_ROLE where  urole.PK_ROLE = role.PK_ROLE) AND CODE_USER = CODE)
);


--旧系统的数据
SELECT
  a.EmployeeID,
  a.RoleDepartmentID,
  c.DepartmentName,
  d.EmployeeNo,
  d.EmployeeName,
  b.RoleName
INTO #temp1
FROM tbEmployeeRoleDepartmentMatch a
  INNER JOIN tbRole b ON a.RoleID = b.RoleID
  INNER JOIN tbDepartment c ON c.DepartmentID = a.RoleDepartmentID
  INNER JOIN tbEmployee d ON a.EmployeeID = d.EmployeeID
WHERE b.RoleName LIKE '绿色通道%'
GROUP BY a.EmployeeID, a.RoleDepartmentID, c.DepartmentName, D.EmployeeNo, D.EmployeeName, b.RoleName



SELECT
  tt.DepartmentName,
  tt.EmployeeNo,
  tt.EmployeeName,
  tt.RoleName,
  tt.RoleName1
FROM (
  SELECT
    a.DepartmentName,
    a.EmployeeNo,
    a.EmployeeName,
    a.RoleName,
    c.RoleName RoleName1
  FROM #temp1 a
    INNER JOIN tbEmployeeRoleDepartmentMatch b
      ON b.EmployeeID = a.EmployeeID AND a.RoleDepartmentID = b.RoleDepartmentID
    INNER JOIN tbRole c ON b.RoleID = c.RoleID
  WHERE c.RoleName LIKE '住院医生'
                              AND b.RoleDepartmentID IN ( SELECT DepartmentID FROM tbDepartmentTree WHERE DepartmentTreeFlag = 7 )
  GROUP BY a.DepartmentName, a.EmployeeNo, a.EmployeeName, a.RoleName, c.RoleName
  UNION ALL
SELECT
  a.DepartmentName,
  a.EmployeeNo,
  a.EmployeeName,
  a.RoleName,
  c.RoleName
FROM #temp1 a
  INNER JOIN tbEmployeeRoleDepartmentMatch b ON b.EmployeeID = a.EmployeeID AND a.RoleDepartmentID = b.RoleDepartmentID
  INNER JOIN tbRole c ON b.RoleID = c.RoleID
WHERE c.RoleName LIKE '住院护士'
AND b.RoleDepartmentID IN ( SELECT DepartmentID FROM tbDepartmentTree WHERE DepartmentTreeFlag = 7)
GROUP BY a.DepartmentName, a.EmployeeNo, a.EmployeeName, a.RoleName, c.RoleName )tt
GROUP BY tt.DepartmentName, tt.EmployeeNo, tt.EmployeeName, tt.RoleName, tt.RoleName1
ORDER BY tt.DepartmentName, tt.EmployeeNo