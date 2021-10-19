/**
 * Generated ${date} by Hibernate Tools ${version}
 * mesapplis versius Wandji IT
 * @author : Cedric Ndanga Wandji
 */

${pojo.getPackageDeclaration()}
${pojo.importType("wandji.mesapplis.model.base."+"Base"+pojo.getDeclarationName())}		<#-- cnw -->

<#assign classbody>
<#include "PojoTypeDeclaration.ftl"/> {

<#if !pojo.isInterface()>
<#--
<#include "PojoFields.ftl"/>
-->

<#include "PojoConstructors.ftl"/>

<#--
<#include "PojoPropertyAccessors.ftl"/>

<#include "PojoToString.ftl"/>

<#include "PojoEqualsHashcode.ftl"/>
-->
<#else>
<#include "PojoInterfacePropertyAccessors.ftl"/>

</#if>
<#include "PojoExtraClassCode.ftl"/>

}
</#assign>

${pojo.generateImports()}
${classbody}
