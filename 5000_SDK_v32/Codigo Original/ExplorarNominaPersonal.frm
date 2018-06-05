[Forma]
Clave=ExplorarNominaPersonal
Nombre=Explorando - Movimientos Nómina
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(Info.Personal, Info.Nombre)
PosicionInicialIzquierda=209
PosicionInicialArriba=249
PosicionInicialAltura=597
PosicionInicialAncho=862
EsConsultaExclusiva=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=492

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
ExpresionesAlMostrar=Asigna(Temp.Reg, SQL(<T>spVerUltimaNomina<T>))<BR>Asigna(Info.ID,    Temp.Reg[1])<BR>Asigna(Info.Mov,   Temp.Reg[2])<BR>Asigna(Info.MovID, Temp.Reg[3])
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaT
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=30
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
ListaEnCaptura=(Lista)
FiltroGrupo1=NominaD.Concepto
FiltroAutoCampo=NominaD.Personal
FiltroAutoValidar=NominaD.Personal
FiltroValida1=NominaD.Concepto
FiltroGrupo2=Personal.Departamento
FiltroValida2=Personal.Departamento
FiltroTodo=S
FiltroTodoFinal=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
PestanaOtroNombre=S
PestanaNombre=Registros
IconosNombre=NominaT:Nomina.Mov+<T> <T>+NominaT:Nomina.MovID
FiltroGeneral=NominaD.Personal=<T>{Info.Personal}<T> AND Nomina.Estatus=<T>CONCLUIDO<T>

[Lista.Columnas]
0=157
1=209
Personal=64
NombreCompleto=248
Movimiento=124
Percepcion=96
Deduccion=99
Estadistica=81

[Lista.Percepcion]
Carpeta=Lista
Clave=Percepcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Deduccion]
Carpeta=Lista
Clave=Deduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.preliminar]
Nombre=preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
NombreDesplegar=Personalizar &Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Nomina.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Nomina.Actualizar Arbol]
Nombre=Actualizar Arbol
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Lista.Estadistica]
Carpeta=Lista
Clave=Estadistica
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Nomina.Concepto]
Carpeta=Lista
Clave=Nomina.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=Nomina.Concepto
Nomina.Concepto=Percepcion
Percepcion=Deduccion
Deduccion=Estadistica
Estadistica=(Fin)











[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=preliminar
preliminar=Excel
Excel=Campos
Campos=(Fin)
