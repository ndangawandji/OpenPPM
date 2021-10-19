/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + ".", 0)}
*/
<#include "Ejb3TypeDeclaration.ftl"/>
${pojo.getClassModifiers()} ${pojo.getDeclarationType()} ${pojo.getDeclarationName()} ${"extends Base"+pojo.getDeclarationName()} <#-- ${pojo.getImplementsDeclaration()} -->
