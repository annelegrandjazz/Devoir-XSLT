<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <!-- exclusion du préfixe tei des résultats lors de la sortie HTML  -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <!-- Suppression des espaces non voulus -->
    
    <!-- Les variables pour récupérer les pages html -->
    <xsl:variable name="Accueil" select="concat('Accueil', '.html')"/>
    <xsl:variable name="Personnes" select="concat('Personnes', '.html')"/>
    <xsl:variable name="Lieux" select="concat('Lieux', '.html')"/>
    
    <!-- Règles des trois pages HTML -->
    <xsl:template match="TEI">
        
     <!-- Page d'accueil -->
      <xsl:result-document href="{$Accueil}">
        <html>
        <head>
            <link rel="stylesheet" type="text/css" href="Sevigne_Legrand.css"/>
            <meta charset="UTF-8"/>
            <title>Pages HTML des lettres de Madame de Sévigné</title>       
            <meta name="author" content="A. Legrand"/>
        </head>
        <body>
            <!-- Sommaire -->
            <nav class="nav">
                <ul>
                    <li class="nav-link">
                        <a href="{$Accueil}">Accueil</a>
                    </li>
                    <li class="nav-link">
                        <a href="{$Personnes}">Index des noms de personnes</a>
                    </li>
                    <li class="nav-link">
                        <a href="{$Lieux}">Index des lieux</a>
                    </li>
                </ul>
            </nav> 
            
            <img src="bandeau.jpg" style="width:100%"></img>
            
            <!-- Header -->
            <div class="background">
                <div class="titres">
            <h1>
                <xsl:value-of select="/TEI//titleStmt[1]/title[@type='main']"/>
            </h1>
                    <h2> 
                        <xsl:value-of select="//title[@type='subtitles']"/>
                        <li>
                            <a href="{//publicationStmt/distributor/@facs}">Lien vers l'édition imprimée disponible sur Gallica</a>
                        </li>
                    </h2>
                 </div>
            </div>
            
            <!-- Corps du texte -->
            <xsl:for-each select="/TEI//div">
                <div class="lettre">
                    <xsl:copy select=".">
                        <div class="col-sm-5" style="text-align:right;margin-top:55px">
                            <a href="https://www.carnavalet.paris.fr/fr/collections/la-marquise-de-sevigne-1626-1696">
                           <img src="Sevigne.jpg" style="width:200px;height:auto"/>
                        </a>
                        </div>
                        <br/>
                        <h3>
                            <xsl:value-of select="head"/>
                        </h3>
                        <h4>
                            <xsl:value-of select="opener"/> 
                        </h4>
                        <xsl:for-each select="p">
                            <p>   
                               <xsl:apply-templates/>
                            </p>
                            </xsl:for-each>                        
                    </xsl:copy>
                </div>
            </xsl:for-each>
            
            
            
            <!-- Notes de bas de page -->
            <div class="lettre">
                <xsl:for-each select="/TEI/text/body/div/p/note">
                    <note class="notesbp">
                        <xsl:attribute name="id">
                            <xsl:number level="any" format="1"/>
                        </xsl:attribute>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:text>#</xsl:text>
                                <text>n</text>
                                <xsl:number level="any" format="1"/>
                            </xsl:attribute>
                            <xsl:number level="any" format="1. "/></a>
                        <xsl:apply-templates/>
                    </note>
                    <br/>
                </xsl:for-each>
            </div>
            
            <!-- Footer -->
            <div class="footer">
                <xsl:value-of select="concat(/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/respStmt[1]/resp[1], ' par Anne Legrand (promotion 2019-2020).')"/>
                <br/>
                <br/>                
                <a href="http://www.chartes.psl.eu/">
                    <img src="chartes.png" style="width:100px;height:auto"/> 
                </a> 
            </div>
                     
        </body> 
        </html>
      </xsl:result-document> 
        
        <!-- Page d'index des noms de personnes -->
        <xsl:result-document href="{$Personnes}">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="Sevigne_Legrand.css"/>
                    <meta charset="UTF-8"/>
                    <title>Pages HTML des lettres de Madame de Sévigné</title>       
                    <meta name="author" content="A. Legrand"/>
                </head>
                <body>
                    <!-- Header -->
                    <div class="background">
                        <div class="titres">
                            <h1>
                                <xsl:value-of select="/TEI//titleStmt[1]/title[@type='main']"/>
                            </h1>
                            <h2>
                                <xsl:value-of select="//title[@type='subtitles']"/>
                            </h2>
                        </div>
                    </div>
                    
                    <!-- Sommaire -->
                    <nav class="nav">
                        <ul>
                            <li class="nav-link">
                                <a href="{$Accueil}">Accueil</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$Personnes}">Index des noms de personnes</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$Lieux}">Index des noms de lieux</a>
                            </li>
                        </ul>
                    </nav>   
                    
                    <!-- Corps -->
                    <div class="lettre">
                        <h3>Index des noms de personnes</h3>
                        <xsl:apply-templates select="/TEI//particDesc"/>
                    </div>
                    
                    <!-- Footer -->
                    <div class="footer">
                        <xsl:value-of select="concat(/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/respStmt[1]/resp[1], ' par Anne Legrand (promotion 2019-2020).')"/>
                        <br/>
                        <br/>
                        <a href="http://www.chartes.psl.eu/">
                        <img src="chartes.png" style="width:100px;height:auto"/> 
                        </a>
                    </div>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Page d'index des noms de lieux -->
        <xsl:result-document href="{$Lieux}">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="Sevigne_Legrand.css"/>
                    <meta charset="UTF-8"/>
                    <title>Pages HTML des lettres de Madame de Sévigné</title>       
                    <meta name="author" content="A. Legrand"/>
                </head>
                <body>
                    <!-- Header -->
                    <div class="background">
                        <div class="titres">
                            <h1>
                                <xsl:value-of select="/TEI//titleStmt[1]/title[@type='main']"/>
                            </h1>
                            <h2>
                                <xsl:value-of select="//title[@type='subtitles']"/>
                            </h2>
                        </div>
                    </div>
                    
                    <!-- Sommaire -->
                    <nav class="nav">
                        <ul>
                            <li class="nav-link">
                                <a href="{$Accueil}">Accueil</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$Personnes}">Index des noms de personnes</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$Lieux}">Index des noms de lieux</a>
                            </li>
                        </ul>
                    </nav>  
                    
                    <!-- Corps -->
                    <div class="lettre">
                        <h3>Index des noms de lieux</h3>
                        <xsl:apply-templates select="/TEI//settingDesc"/>
                    </div>
                    
                    <!-- Footer -->
                    <div class="footer">
                        <xsl:value-of select="concat(/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/respStmt[1]/resp[1], ' par Anne Legrand (promotion 2019-2020).')"/>
                        <br/>
                        <br/>                
                        <a href="http://www.chartes.psl.eu/">
                            <img src="chartes.png" style="width:100px;height:auto"/> 
                        </a> 
                    </div>
                    
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Règles pour l'italique dans le texte -->
    <xsl:template match="hi[@rend = 'italic']">
        <span style="font-style:italic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="emph[@rend = 'italic']">
        <span style="font-style:italic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>  
    
    <!-- Règles des notes de bas de page -->
    <xsl:template match="/TEI/text/body/div/p/note">
        <sup>
            <xsl:attribute name="id">
                <text>n</text>
                <xsl:number level="any" format="1"/>
            </xsl:attribute>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number level="any" format="1"/>
                </xsl:attribute>
                <xsl:number level="any" format="1"/>
            </a>
        </sup>
    </xsl:template>
    
    <!-- Règles de l'index des noms de personnes -->
    <xsl:template match="/TEI//particDesc">     
        <xsl:for-each select="//person">
            <xsl:sort select=".//surname" order="ascending"></xsl:sort>
            <person>
                <xsl:attribute name="id">
                    <xsl:value-of select="./[@xml:id]"/>
                </xsl:attribute>
                <xsl:choose> 
                    <xsl:when test=".//addName = 'mademoiselle'"> <!-- Ajout du addname de mademoiselle -->
                        <xsl:value-of select="concat(.//surname,', ',.//addName, ' ',.//nameLink,'')"/> 
                    </xsl:when>
                    <xsl:when test=".//addName = 'Ninon'"> <!-- Ajout du addname de Ninon -->
                        <xsl:value-of select="concat(.//surname,', ',.//forename, ' ',.//nameLink,', dit ',.//addName)"/> 
                    </xsl:when>
                    <xsl:when test=".//addName != 'Ninon'"> <!-- Ajout des addName différent de Ninon -->
                        <xsl:value-of select="concat(.//surname,', ',.//forename, '',.//nameLink,', dit ',.//addName)"/> 
                    </xsl:when>
                    <xsl:when test=".//genName != ''"> <!-- Ajout de Louis XIV -->
                        <xsl:value-of select="concat(.//surname,', ',.//roleName, ', ',.//forename, ' ',.//genName, ', ',.//forename, ' ',.//nameLink,'')"/> 
                    </xsl:when>
                    <xsl:when test=".//nameLink != ''"> <!-- Ajout des roleName comte, duc, etc. -->
                        <xsl:value-of select="concat(.//surname,', ',.//roleName, ' ',.//forename, ' ',.//nameLink,'')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(.//surname,', ',.//forename,'')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </person>
            <br/>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- Hyperliens des noms de personnes vers l'index -->
    <xsl:template match="persName">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="$Personnes"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </a> 
    </xsl:template>
    
    
    <!-- Règles de l'index des noms de lieux -->
    <xsl:template match="/TEI//settingDesc">     
        <xsl:for-each select="//place">
            <xsl:sort select="placeName" order="ascending"></xsl:sort>
            <place>
                <xsl:attribute name="id">                    
                    <xsl:value-of select="./[@xml:id]"/>
                </xsl:attribute>
                <xsl:choose> <!-- Pour enlever la répétition du nom équivalent au settlement-->
                    <xsl:when test=".//name = .//settlement">
                        <xsl:value-of select="concat(.//name,', ',.//country,'.')"/>
                    </xsl:when>
                    <xsl:otherwise><xsl:value-of select="concat(.//name,', ',.//settlement,' ',.//district[1],', ',.//country,'.')"/>
                    </xsl:otherwise>
                </xsl:choose>                            
                 </place>            
            <br/>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- Hyperliens des noms de lieux vers l'index -->
    <xsl:template match="placeName">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="$Lieux"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </a> 
    </xsl:template>
    
</xsl:stylesheet>