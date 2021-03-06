<#--  /** default constructor */ -->
    public ${"Base"+pojo.getDeclarationName()}() {		<#-- cnw adding prefix Base for adequation with class name -->
    }

<#if pojo.needsMinimalConstructor()>	<#-- /** minimal constructor */ -->
    public ${"Base"+pojo.getDeclarationName()}(${c2j.asParameterList(pojo.getPropertyClosureForMinimalConstructor(), jdk5, pojo)}) {
<#if pojo.isSubclass() && !pojo.getPropertyClosureForSuperclassMinimalConstructor().isEmpty()>
        super(${c2j.asArgumentList(pojo.getPropertyClosureForSuperclassMinimalConstructor())});        
</#if>
<#foreach field in pojo.getPropertiesForMinimalConstructor()>
        this.${field.name} = ${field.name};
</#foreach>
    }
</#if>