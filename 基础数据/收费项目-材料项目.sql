--
SELECT
  material.MaterialID,
  MaterialNo,
  MaterialName,
  SpellCode,
  WBCode,
  Unit,
  UnitPrice,
  DisPubPatientSelfPayFlag,--区公医先自费类型
  PreSelfPayFlag,--先自费类型
  '5-' + convert(VARCHAR(20), material.MaterialID) YB_ID
FROM tbMaterial material
  INNER JOIN tbMaterialDetail detail ON material.MaterialID = detail.MaterialID
WHERE IdleFlag = 0
