/**
 * Generated ${date} by Hibernate Tools ${version}
 * Openppm versius Devoteam
 * @author : Xavier De Langautier, Cedric Ndanga Wandji
 */

${pojo.getPackageDeclaration()}
${pojo.importType("es.sm2.openppm.model.base."+"Base"+pojo.getDeclarationName())}		<#-- cnw -->

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