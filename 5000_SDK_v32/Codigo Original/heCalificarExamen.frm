[Forma]
Clave=heCalificarExamen
Icono=111
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialAlturaCliente=134
PosicionInicialAncho=279
Nombre=Calificar Examen
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=Calificar<BR>Reporte
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=451
PosicionInicialArriba=264
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Personal<BR>Info.Curso<BR>Info.Examen1
CarpetaVisible=S
[(Variables).Info.Curso]
Carpeta=(Variables)
Clave=Info.Curso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[(Variables).Info.Personal]
Carpeta=(Variables)
Clave=Info.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
[Acciones.Calificar]
Nombre=Calificar
Boton=0
NombreDesplegar=C&alificar
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=heCalificarExamenF
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Asigna<BR>heCalificarExamenF
[Acciones.Reporte]
Nombre=Reporte
Boton=0
NombreDesplegar=&Emitir Reporte
EnBarraAcciones=S
TipoAccion=Reportes Pantalla
ClaveAccion=heExamenCalificacion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Asigna<BR>heExamenCalificacion
[Acciones.Calificar.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
[Acciones.Calificar.heCalificarExamenF]
Nombre=heCalificarExamenF
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Si<BR>    SQL(<T>SELECT COUNT(0) FROM heExamenPersonal p JOIN heExamen e ON e.Curso=p.Curso AND e.NPregunta=p.NPregunta<BR>                 JOIN heExamenCurso c ON c.Curso=e.Curso WHERE e.Tipo=:tAbierta AND p.Personal=:tPer AND c.Curso=:tCurso<BR>                 AND c.Estatus=:tEstatus AND p.IDExamen=:nExamen<T><BR>                 ,<T>ABIERTA<T>,Info.Personal,Info.Curso,<T>ALTA<T>,Info.Examen1)>0<BR>Entonces<BR>    Forma(<T>heCalificarExamenF<T>)<BR>SiNo<BR>    ReportePantalla(<T>heExamenCalificacion<T>)<BR>Fin
[(Variables).Info.Examen1]
Carpeta=(Variables)
Clave=Info.Examen1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Reporte.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S
[Acciones.Reporte.heExamenCalificacion]
Nombre=heExamenCalificacion
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=heExamenCalificacion
Activo=S
Visible=S

