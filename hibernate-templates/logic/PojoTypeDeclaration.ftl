/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + ".", 0)}
*/
<#include "Ejb3TypeDeclaration.ftl"/>
${pojo.getClassModifiers()} ${pojo.getDeclarationType()} ${"Base"+pojo.getDeclarationName()} ${pojo.getExtendsDeclaration()} ${pojo.getImplementsDeclaration()}
