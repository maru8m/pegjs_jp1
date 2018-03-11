UnitDefinitionFile = 
  unit_definitions : UnitDefinition +
  {
    return {
      "unit_definition_file": unit_definitions
    }
  }
UnitDefinition = 
  unit_attribute_parameter : UnitAttributeParameter
  _ "{"
  unit_definition_parameter : UnitDefinitionParameter
  _ "}"
  {
    return {
      unit_attribute_parameter,
      unit_definition_parameter,
    }
  }
UnitDefinitionParameter =
  UnitDefinitionParameter_JobGroup /
  UnitDefinitionParameter_Jobnet /
  UnitDefinitionParameter_Job /
  UnitDefinitionParameter_ManagerUnit /
  UnitDefinitionParameter_StartCondition /
  UnitDefinitionParameter_JobnetConnector
UnitDefinitionParameter_JobGroup =
  attribute_devinition : AttributeDefinition
  unit_configuration_definition : UnitConfigurationDefinition
  job_group_definition : JobGroupDefinition
  {
    return {
      "attribute_definition": attribute_devinition,
      "unit_configuration_definition": unit_configuration_definition,
      "job_group_definition": job_group_definition,
    }
  }
UnitDefinitionParameter_Jobnet =
  AttributeDefinition
  UnitConfigurationDefinition
  JobnetDefinition
  {
    return {
    }
  }
UnitDefinitionParameter_Job =
  AttributeDefinition
  JobDefinition
  {
    return {
    }
  }
UnitDefinitionParameter_ManagerUnit =
  AttributeDefinition
  ManagerUnitDefinition
  {
    return {
    }
  }
UnitDefinitionParameter_StartCondition =
  AttributeDefinition
  StartConditionDefinition
  {
    return {
    }
  }
UnitDefinitionParameter_JobnetConnector =
  AttributeDefinition
  JobnetConnectorDefinition
  {
    return {
    }
  }
AttributeDefinition =
  ty : TY
  cm : CM ?
  {
    return {
      "unit_type": ty,
      "comment": cm,
    }
  }
UnitConfigurationDefinition =
  EL *
  SZ ?
LateralIconCountTimesLongitudinalIconCount =
  lateral_icon_count : [0-9][0-9]?[0-9]?
  "x"
  longitudinal_icon_count : [0-9][0-9]?[0-9]?
  {
    return {
      lateral_icon_count,
      longitudinal_icon_count,
    }
  }
JobGroupDefinition = 
  OP ?
  // CL ?
  // SDD ?
  // MD ?
  // STT ?
  // GTY ?
  // NCL ?
  // NCN ?
  // NCS ?
  // NCEX ?
  // NCHN ?
  // NCSV ?

JobnetDefinition = _
JobDefinition = _
ManagerUnitDefinition = _
StartConditionDefinition = _
JobnetConnectorDefinition = _
JobGroup = 
  _ unit_attribute_parameter : UnitAttributeParameter
  _ "{"
  ty : LineTY
  cm : LineCM ?
  unit_definitions : UnitDefinition *
  _ "}"
  _
  {
    return {
      unit_attribute_parameter,
      ty,
      cm,
      el
    }
  }
LineTY =
  _ "ty=" unit_type : "g" ";"
  {
    return {"unit_type": "g"};
  }

LineCM =
  _ "cm="
  [\"]
  comment : ([^#"] / "##" / "#\"") *
  [\"]
  ";"
  {
    return comment.join("");
  }
UnitType =
  unit_type : (
    "g"/"mg"/"n"/"rn"/"rm"/"rr"/"rc"/"mn"/"j"/"rj"/"pj"/
    "rp"/"qj"/"rq"/"jdj"/"rjdj"/"orj"/"rorj"/"evwj"/
    "revwj"/"flwj"/"rflwj"/"mlwj"/"rmlwj"/"mqwj"/
    "rmqwj"/"mswj"/"rmswj"/"lfwj"/"rlfwj"/"ntwj"/
    "rntwj"/"tmwj"/"rtmwj"/"evsj"/"revsj"/"mlsj"/
    "rmlsj"/"mqsj"/"rmqsj"/"mssj"/"rmssj"/"cmsj"/
    "rcmsj"/"pwlj"/"rpwlj"/"pwrj"/"rpwrj"/"cj"/"rcj"/"cpj"/"rcpj"/"nc"
  )
  {
    return unit_type
  }
Comment =
  [\"]
  comment : ([^#"] / "##" / "#\"") *
  [\"]
  {
    return comment.join("");
  }
CharComment = [^"]

UnitAttributeParameter = 
  "unit="
  unit_name : UnitName
  permission_mode : PermissionMode?
  JP1_user_name : JP1UserName?
  JP1_resource_group_name : JP1ResourceGroupName?
  ";"
  { 
    return {
      "unit_name" : unit_name,
      "permission_mode" : permission_mode,
      "JP1_user_name" : JP1_user_name,
      "JP1_resource_group_name" : JP1_resource_group_name,
    }
  }
UnitName = 
  unit_name : CharUnitName+
  {
    return unit_name.join("")
  }
CharUnitName = [^"&'*?[\]^‘{｜}~;,]
PermissionMode = 
  ","
  permission_mode : 
  	([0-7][0-7][0-7][0-7])?
  {
    return permission_mode === null ? "" : permission_mode.join("")
  }
JP1UserName =
  ","
  JP1_user_name : CharJP1UserName*
  {
    return JP1_user_name.join("")
  }
CharJP1UserName = [^*/\\"'^\[\]{}() : ;|=,+?<>\s\t]
JP1ResourceGroupName =
  ","
  JP1_resource_group_name : CharJP1ResourceGroupName*
  {
    return JP1_resource_group_name.join("")
  }
CharJP1ResourceGroupName = [0-1a-zA-Z_]
_  = [ \t\r\n]*
__ = [ \t\r\n]+
TY = 
  _ "ty=" unit_type : UnitType ";"
  {
    return unit_type
  }
CM = 
  _ "cm=" comment : Comment ";"
  {
    return comment
  }
EL = 
  _ "el=" 
  unit_name : UnitName
  "," 
  unit_type : UnitType
  ","
  "+" h : [0-9][0-9]?[0-9]?[0-9]?[0-9]?
  "+" v : [0-9][0-9]?[0-9]?[0-9]?[0-9]?
  ";"
  {
    return {
      "definition_type": "el",
      "unit_name": unit_name,
      "unit_type": unit_type,
      "h": h,
      "v": v,
    }
  }
SZ = 
  _ "sz="
  size : LateralIconCountTimesLongitudinalIconCount
  ";"
  {
    return {
      "definition_type": "sz",
      "lateral_icon_count_times_longitudinal_icon_count": size == null ? "" : size
    }
  }
OP = 
  _ "op="
  open_day : OpenDay
  ";"
  {
    return {
      "open_day": open_day
    }
  }
OpenDay = 
  YYYYMMDD / DayOfWeek
YYYYMMDD = 
  yyyy : [0-9][0-9][0-9][0-9]
  "/"
  mm : [0-9][0-9]
  "/"
  dd : [0-9][0-9]
  {
    return yyyy + "/" + mm + "/" + dd
  }
DayOfWeek = 
  "su" / "mo" / "tu" / "we" / "th" / "fr" / "sa"