[Forma]
Clave=RepNominaAcum
Nombre=Nomina - Acumulados
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=523
PosicionInicialArriba=121
PosicionInicialAltura=367
PosicionInicialAncho=320
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=446
EsMovimiento=S
MovModulo=NOM
TituloAuto=S
MovEspecificos=Todos
BarraAyuda=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.FechaD, PrimerDiaAño(Año(Hoy)))<BR>Asigna(Info.FechaA, Hoy)<BR>Asigna(Rep.NominaAcum, <T>Persona / Concepto<T>)<BR>//Asigna(Rep.PersonaEspecifica, Nulo)<BR>Asigna(Info.CentroCostos, Nulo)<BR>//Asigna(Info.Departamento, <T>(Todos)<T>)<BR>Asigna(Info.DepartamentoD, <T>(Todos)<T>)<BR>Asigna(Info.DepartamentoA, <T>(Todos)<T>)<BR>Asigna(Info.PersonalD, SQL(<T>SELECT MIN(Personal) FROM Personal<T>))<BR>Asigna(Info.PersonalA, SQL(<T>SELECT MAX(Personal) FROM Personal<T>))<BR>Asigna(Info.Puesto, <T>(Todos)<T>)<BR>Asigna(Info.PersonalCat, <T>(Todos)<T>)<BR>Asigna(Info.PersonalGrupo, <T>(Todos)<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Modulo, <T>NOM<T>)<BR>Asigna(Info.Desglosar, <T>Si<T>)<BR>Asigna(Info.VerEstadisticas, <T>Si<T>)<BR>Asigna(Info.ConceptoNominaRecibo, <T>(Todos)<T>)<BR>Asigna(Rep.Titulo, <T>Nómina - Acumulados<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Rep.NominaAcum]
Carpeta=(Variables)
Clave=Rep.NominaAcum
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(Info.ConceptoNominaRecibo=<T>(Todos)<T>, Asigna(Info.ConceptoNominaRecibo, Nulo))<BR>Si(Info.DepartamentoD=<T>(Todos)<T>, Asigna(Info.DepartamentoD, Nulo))<BR>Si(Info.DepartamentoA=<T>(Todos)<T>, Asigna(Info.DepartamentoA, Nulo))<BR>Si(Info.PersonalD=<T>(Todos)<T>, Asigna(Info.PersonalD, Nulo))<BR>Si(Info.PersonalA=<T>(Todos)<T>, Asigna(Info.PersonalA, Nulo))<BR>Si(Info.Puesto=<T>(Todos)<T>, Asigna(Info.Puesto, Nulo))<BR>Si(Info.PersonalCat=<T>(Todos)<T>, Asigna(Info.PersonalCat, Nulo))<BR>Si(Info.PersonalGrupo=<T>(Todos)<T>, Asigna(Info.PersonalGrupo, Nulo))<BR>Asigna(Info.Filtro,<BR><T>Nomina.Empresa=<T>+Comillas(Empresa)+<T> AND <T>+<BR><T>Nomina.Estatus=<T>+Comillas(<T>CONCLUIDO<T>)+<T> AND <T>+<BR><T>Nomina.Moneda =<T>+Comillas(Info.Moneda)+<T> AND <T>+<BR><T>Nomina.FechaA BETWEEN <T>+Comillas(FechaFormatoServidor(Info.FechaD))+<T> AND <T>+Comillas(FechaFormatoServidor(Info.FechaA))+<BR>Si(no General.NomAuto, <T> AND NominaD.Modulo = <T>+Comillas(<T>NOM<T>))+<BR>Si(Info.VerEstadisticas=<T>No<T>,       <T> AND NominaD.Movimiento <> <T>+Comillas(<T>Estadistica<T>), <T><T>)+<BR>Si(ConDatos(Info.PersonalD), <T> AND NominaD.Personal >= <T>+Comillas(Info.PersonalD), <T><T>)+<BR>Si(ConDatos(Info.PersonalA), <T> AND NominaD.Personal <= <T>+Comillas(Info.PersonalA), <T><T>)+<BR>Si(ConDatos(Info.ConceptoNominaRecibo),         <T> AND NominaD.Concepto = <T>+Comillas(Info.ConceptoNominaRecibo), <T><T>)+<BR>Si(ConDatos(Info.DepartamentoD),     <T> AND Personal.Departamento >= <T>+Comillas(Info.DepartamentoD), <T><T>)+<BR>Si(ConDatos(Info.DepartamentoA),     <T> AND Personal.Departamento <= <T>+Comillas(Info.DepartamentoA), <T><T>)+<BR>Si(ConDatos(Info.Puesto),           <T> AND Personal.Puesto = <T>+Comillas(Info.Puesto), <T><T>)+<BR>Si(ConDatos(Info.PersonalCat),      <T> AND Personal.Categoria = <T>+Comillas(Info.PersonalCat), <T><T>)+<BR>Si(ConDatos(Info.PersonalGrupo),    <T> AND Personal.Grupo = <T>+Comillas(Info.PersonalGrupo), <T><T>)+<BR>Si(ConDatos(Info.CentroCostos),     <T> AND Personal.CentroCostos = <T>+Comillas(Info.CentroCostos), <T><T>)+<BR>Si(ConDatos(Rep.MovEspecifico),     <T> AND Nomina.Mov = <T>+Comillas(Rep.MovEspecifico), <T><T>)<BR>)<BR>Asigna(Info.Cantidad, SQL(<T>SELECT COUNT(DISTINCT NominaD.Personal) FROM Nomina, NominaD, Personal, MovTipo WHERE NominaD.ID=Nomina.ID AND NominaD.Personal=Personal.Personal AND MovTipo.Modulo=:tModulo AND MovTipo.Mov = Nomina.Mov AND <T>+Info.Filtro, <T>NOM<T>))<BR>Caso Rep.NominaAcum<BR>  Es <T>Persona / Concepto<T> Entonces  ReportePantalla(<T>NominaAcumPersonal<T>)<BR>  Es <T>Concepto / Persona<T> Entonces  ReportePantalla(<T>NominaAcumConcepto<T>)<BR>  Es <T>Concentrado<T> Entonces  ReportePantalla(<T>NominaAcumConcentrado<T>)<BR>  Es <T>Concentrado Centro Costos<T> Entonces  ReportePantalla(<T>NominaAcumConcentradoCC<T>)<BR>Fin
[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S


[(Variables).Info.Puesto]
Carpeta=(Variables)
Clave=Info.Puesto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[(Variables).Info.PersonalCat]
Carpeta=(Variables)
Clave=Info.PersonalCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.PersonalGrupo]
Carpeta=(Variables)
Clave=Info.PersonalGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ConceptoNominaRecibo]
Carpeta=(Variables)
Clave=Info.ConceptoNominaRecibo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(Info.ConceptoNominaRecibo=<T>(Todos)<T>, Asigna(Info.ConceptoNominaRecibo, Nulo))<BR>Si(Info.DepartamentoD=<T>(Todos)<T>, Asigna(Info.DepartamentoD, Nulo))<BR>Si(Info.DepartamentoA=<T>(Todos)<T>, Asigna(Info.DepartamentoA, Nulo))<BR>Si(Info.PersonalD=<T>(Todos)<T>, Asigna(Info.PersonalD, Nulo))<BR>Si(Info.PersonalA=<T>(Todos)<T>, Asigna(Info.PersonalA, Nulo))<BR>Si(Info.Puesto=<T>(Todos)<T>, Asigna(Info.Puesto, Nulo))<BR>Si(Info.PersonalCat=<T>(Todos)<T>, Asigna(Info.PersonalCat, Nulo))<BR>Si(Info.PersonalGrupo=<T>(Todos)<T>, Asigna(Info.PersonalGrupo, Nulo))<BR>Asigna(Info.Filtro,<BR><T>Nomina.Empresa=<T>+Comillas(Empresa)+<T> AND <T>+<BR><T>Nomina.Estatus=<T>+Comillas(<T>CONCLUIDO<T>)+<T> AND <T>+<BR><T>Nomina.Moneda =<T>+Comillas(Info.Moneda)+<T> AND <T>+<BR><T>Nomina.FechaA BETWEEN <T>+Comillas(FechaFormatoServidor(Info.FechaD))+<T> AND <T>+Comillas(FechaFormatoServidor(Info.FechaA))+<BR>Si(no General.NomAuto, <T> AND NominaD.Modulo = <T>+Comillas(<T>NOM<T>))+<BR>Si(Info.VerEstadisticas=<T>No<T>,       <T> AND NominaD.Movimiento <> <T>+Comillas(<T>Estadistica<T>), <T><T>)+<BR>Si(ConDatos(Info.PersonalD), <T> AND NominaD.Personal >= <T>+Comillas(Info.PersonalD), <T><T>)+<BR>Si(ConDatos(Info.PersonalA), <T> AND NominaD.Personal <= <T>+Comillas(Info.PersonalA), <T><T>)+<BR>Si(ConDatos(Info.ConceptoNominaRecibo),         <T> AND NominaD.Concepto = <T>+Comillas(Info.ConceptoNominaRecibo), <T><T>)+<BR>Si(ConDatos(Info.DepartamentoD),     <T> AND Personal.Departamento >= <T>+Comillas(Info.DepartamentoD), <T><T>)+<BR>Si(ConDatos(Info.DepartamentoA),     <T> AND Personal.Departamento <= <T>+Comillas(Info.DepartamentoA), <T><T>)+<BR>Si(ConDatos(Info.Puesto),           <T> AND Personal.Puesto = <T>+Comillas(Info.Puesto), <T><T>)+                               <BR>Si(ConDatos(Info.PersonalCat),      <T> AND Personal.Categoria = <T>+Comillas(Info.PersonalCat), <T><T>)+<BR>Si(ConDatos(Info.PersonalGrupo),    <T> AND Personal.Grupo = <T>+Comillas(Info.PersonalGrupo), <T><T>)+<BR>Si(ConDatos(Info.CentroCostos),     <T> AND Personal.CentroCostos = <T>+Comillas(Info.CentroCostos), <T><T>)+<BR>Si(ConDatos(Rep.MovEspecifico),     <T> AND Nomina.Mov = <T>+Comillas(Rep.MovEspecifico), <T><T>)<BR>)<BR>Asigna(Info.Cantidad, SQL(<T>SELECT COUNT(DISTINCT NominaD.Personal) FROM Nomina, NominaD, Personal, MovTipo WHERE NominaD.ID=Nomina.ID AND NominaD.Personal=Personal.Personal AND MovTipo.Modulo=:tModulo AND MovTipo.Mov = Nomina.Mov AND <T>+Info.Filtro, <T>NOM<T>))<BR>Caso Rep.NominaAcum<BR>  Es <T>Persona / Concepto<T> Entonces  ReporteImpresora(<T>NominaAcumPersonal<T>)<BR>  Es <T>Concepto / Persona<T> Entonces  ReporteImpresora(<T>NominaAcumConcepto<T>)<BR>  Es <T>Concentrado<T> Entonces  ReporteImpresora(<T>NominaAcumConcentrado<T>)<BR>  Es <T>Concentrado Centro Costos<T> Entonces  ReporteImpresora(<T>NominaAcumConcentradoCC<T>)<BR>Fin
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S


[(Variables).Info.CentroCostos]
Carpeta=(Variables)
Clave=Info.CentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S
[(Variables).Info.VerEstadisticas]
Carpeta=(Variables)
Clave=Info.VerEstadisticas
Editar=S
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco

[(Variables).Rep.MovEspecifico]
Carpeta=(Variables)
Clave=Rep.MovEspecifico
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Variables).Info.PersonalD]
Carpeta=(Variables)
Clave=Info.PersonalD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.PersonalA]
Carpeta=(Variables)
Clave=Info.PersonalA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.DepartamentoD]
Carpeta=(Variables)
Clave=Info.DepartamentoD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.DepartamentoA]
Carpeta=(Variables)
Clave=Info.DepartamentoA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.PersonalD
Info.PersonalD=Info.PersonalA
Info.PersonalA=Info.CentroCostos
Info.CentroCostos=Rep.MovEspecifico
Rep.MovEspecifico=Info.DepartamentoD
Info.DepartamentoD=Info.DepartamentoA
Info.DepartamentoA=Info.Puesto
Info.Puesto=Info.PersonalCat
Info.PersonalCat=Info.PersonalGrupo
Info.PersonalGrupo=Info.ConceptoNominaRecibo
Info.ConceptoNominaRecibo=Info.Moneda
Info.Moneda=Rep.NominaAcum
Rep.NominaAcum=Info.Desglosar
Info.Desglosar=Info.VerEstadisticas
Info.VerEstadisticas=Rep.Titulo
Rep.Titulo=(Fin)










[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)





[Lista.Columnas]
0=310
1=282




[Acciones.Preliminar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
