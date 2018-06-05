[Forma]
Clave=GRP_Presupuesto
Nombre=GRP - Presupuesto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=162
PosicionInicialArriba=271
PosicionInicialAlturaCliente=454
PosicionInicialAncho=956
Comentarios=Info.Ejercicio
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=92
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo)
PosicionSeccion2=91

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GRP_Presupuesto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
HojaIndicador=S
HojaMantenerSeleccion=S
FiltroGeneral=GRP_Presupuesto.Ejercicio={Info.Ejercicio}

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

[Lista.Columnas]
Cuenta=95
GrupoFuncional=83
Funcion=53
SubFuncion=66
ProgramaSectorial=97
ActividadInstitucional=111
ActividadPrioritaria=99
Proyecto=68
TipoGasto=58
FuenteFinanciamiento=114
GF=37
Programa=57
AI=41
AP=51
Partida=83
TG=64
FF=55
Importe=88
Observaciones=174
Reduccion=69
Ampliacion=72
Neto=89

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Ejercicio]
Nombre=Ejercicio
Boton=53
NombreDesplegar=&Ejercicio
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Si<BR>  Forma(<T>EspecificarEjercicio<T>)<BR>Entonces<BR>  Forma.ActualizarVista <BR>Fin

[Lista.GRP_Presupuesto.GF]
Carpeta=Lista
Clave=GRP_Presupuesto.GF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.Funcion]
Carpeta=Lista
Clave=GRP_Presupuesto.Funcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.SubFuncion]
Carpeta=Lista
Clave=GRP_Presupuesto.SubFuncion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.Programa]
Carpeta=Lista
Clave=GRP_Presupuesto.Programa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.AI]
Carpeta=Lista
Clave=GRP_Presupuesto.AI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.AP]
Carpeta=Lista
Clave=GRP_Presupuesto.AP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.Proyecto]
Carpeta=Lista
Clave=GRP_Presupuesto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=4
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.Partida]
Carpeta=Lista
Clave=GRP_Presupuesto.Partida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.TG]
Carpeta=Lista
Clave=GRP_Presupuesto.TG
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.FF]
Carpeta=Lista
Clave=GRP_Presupuesto.FF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_Presupuesto.Importe]
Carpeta=Lista
Clave=GRP_Presupuesto.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total PPEF<BR>Total Reducciones<BR>Total Ampliaciones<BR>Total PEF
Totalizadores2=Suma(GRP_Presupuesto:GRP_Presupuesto.Importe)<BR>Suma(GRP_Presupuesto:Reduccion)<BR>Suma(GRP_Presupuesto:Ampliacion)<BR>Suma(GRP_Presupuesto:GRP_Presupuesto.Neto)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[(Carpeta Totalizadores).Total PPEF]
Carpeta=(Carpeta Totalizadores)
Clave=Total PPEF
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total Reducciones]
Carpeta=(Carpeta Totalizadores)
Clave=Total Reducciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total Ampliaciones]
Carpeta=(Carpeta Totalizadores)
Clave=Total Ampliaciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Total PEF]
Carpeta=(Carpeta Totalizadores)
Clave=Total PEF
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=18
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Periodos]
Nombre=Periodos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Periodos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=GRP_PresupuestoD
Activo=S
ConCondicion=S
Antes=S
Visible=S
GuardarAntes=S
EjecucionCondicion=ConDatos(GRP_Presupuesto:GRP_Presupuesto.Partida) y ConDatos(GRP_Presupuesto:GRP_Presupuesto.ID)
AntesExpresiones=Asigna(Info.Cuenta, GRP_Presupuesto:GRP_Presupuesto.Partida)<BR>Asigna(Info.ID, GRP_Presupuesto:GRP_Presupuesto.ID)<BR>Asigna(Info.Importe, GRP_Presupuesto:GRP_Presupuesto.Neto)

[Ficha.GRP_Presupuesto.Observaciones]
Carpeta=Ficha
Clave=GRP_Presupuesto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x2
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Observaciones]
Nombre=Observaciones
Boton=57
NombreEnBoton=S
NombreDesplegar=&Observaciones
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=Pregunta(GRP_Presupuesto:GRP_Presupuesto.Observaciones)
Activo=S
Visible=S

[Lista.Reduccion]
Carpeta=Lista
Clave=Reduccion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Ampliacion]
Carpeta=Lista
Clave=Ampliacion
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.GRP_Presupuesto.Neto]
Carpeta=Lista
Clave=GRP_Presupuesto.Neto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Preliminar
Preliminar=Nuevo
Nuevo=Eliminar
Eliminar=Ejercicio
Ejercicio=Periodos
Periodos=Observaciones
Observaciones=Excel
Excel=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Cta.Descripcion
Cta.Descripcion=GRP_Presupuesto.Observaciones
GRP_Presupuesto.Observaciones=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GRP_Presupuesto.GF
GRP_Presupuesto.GF=GRP_Presupuesto.Funcion
GRP_Presupuesto.Funcion=GRP_Presupuesto.SubFuncion
GRP_Presupuesto.SubFuncion=GRP_Presupuesto.Programa
GRP_Presupuesto.Programa=GRP_Presupuesto.AI
GRP_Presupuesto.AI=GRP_Presupuesto.AP
GRP_Presupuesto.AP=GRP_Presupuesto.Proyecto
GRP_Presupuesto.Proyecto=GRP_Presupuesto.Partida
GRP_Presupuesto.Partida=GRP_Presupuesto.TG
GRP_Presupuesto.TG=GRP_Presupuesto.FF
GRP_Presupuesto.FF=GRP_Presupuesto.Importe
GRP_Presupuesto.Importe=Reduccion
Reduccion=Ampliacion
Ampliacion=GRP_Presupuesto.Neto
GRP_Presupuesto.Neto=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Total PPEF
Total PPEF=Total Reducciones
Total Reducciones=Total Ampliaciones
Total Ampliaciones=Total PEF
Total PEF=(Fin)
