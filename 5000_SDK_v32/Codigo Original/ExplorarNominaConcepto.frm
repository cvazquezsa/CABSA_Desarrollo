[Forma]
Clave=ExplorarNominaConcepto
Nombre=Explorando - Nómina por Concepto
Icono=47
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Mov+<T> <T>+Info.MovID
PosicionInicialIzquierda=70
PosicionInicialArriba=82
PosicionInicialAltura=597
PosicionInicialAncho=883
EsConsultaExclusiva=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Temp.Reg, SQL(<T>spVerUltimaNomina<T>))<BR>Asigna(Info.ID,    Temp.Reg[1])<BR>Asigna(Info.Mov,   Temp.Reg[2])<BR>Asigna(Info.MovID, Temp.Reg[3])
PosicionInicialAlturaCliente=570

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
IconosSubTitulo=<T>Persona<T>
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

IconosNombre=NominaT:NominaD.Personal
FiltroGeneral=Nomina.Mov=<T>{Info.Mov}<T> AND Nomina.MovID=<T>{Info.MovID}<T> AND Nomina.Estatus=<T>CONCLUIDO<T> AND Nomina.Ejercicio=<T>{Info.Ejercicio}<T> AND Nomina.Empresa = <T>{Empresa}<T>
[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
Totalizador=0

[Lista.Columnas]
0=80
1=286
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
Totalizador=1

[Lista.Deduccion]
Carpeta=Lista
Clave=Deduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
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

[Acciones.Nomina]
Nombre=Nomina
Boton=50
NombreEnBoton=S
NombreDesplegar=&Nómina
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
Multiple=S
ListaAccionesMultiples=Actualizar Arbol<BR>Actualizar Forma
EjecucionCondicion=Forma(<T>EspecificarMovNomina<T>)

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


[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=Percepcion
Percepcion=Deduccion
Deduccion=Estadistica
Estadistica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=preliminar
preliminar=Excel
Excel=Nomina
Nomina=Campos
Campos=(Fin)
