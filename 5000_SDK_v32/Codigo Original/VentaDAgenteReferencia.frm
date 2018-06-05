[Forma]
Clave=VentaDAgenteReferencia
Nombre=Actividades del Movimiento Referenciado
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=514
PosicionInicialArriba=329
PosicionInicialAlturaCliente=506
PosicionInicialAncho=892
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=91
VentanaExclusiva=S
PosicionSec1=353
VentanaEstadoInicial=Normal
Comentarios=Info.Referencia
ExpresionesAlMostrar=Asigna(Info.ID, SQL(<T>spReferenciaEnModuloID :tRef, :tModulo, @EnSilencio = 0<T>, Info.Referencia, <T>VTAS<T>))

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaDAgente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=Todas
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Automático
ValidarCampos=S
FiltroAplicaEn=VentaDAgente.Estado
FiltroAutoCampo=VentaDAgente.Estado
FiltroAutoValidar=TareaEstado.NombrePlural
FiltroAutoOrden=TareaEstado.Orden
FiltroTodo=S
FiltroTodoFinal=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Actividades
IconosSubTitulo=<T>Actividad<T>
IconosNombre=VentaDAgente:VentaDAgente.Actividad
FiltroGeneral=VentaDAgente.ID={Info.ID}

[Lista.VentaDAgente.Agente]
Carpeta=Lista
Clave=VentaDAgente.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraD]
Carpeta=Lista
Clave=VentaDAgente.HoraD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.HoraA]
Carpeta=Lista
Clave=VentaDAgente.HoraA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agente=79
HoraD=43
HoraA=39
Horas=36
Nombre=249
Fecha=65
Minutos=43
Tiempo=39
Actividad=268
Estado=83
FechaConclusion=88
TiempoEstandar=47
0=310
1=82

[Lista.VentaDAgente.Fecha]
Carpeta=Lista
Clave=VentaDAgente.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Tiempo]
Carpeta=Lista
Clave=Tiempo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Gris

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
Totalizadores1=Conteo<BR>Tiempo<BR>Estándar<BR>Diferencia
Totalizadores2=Conteo<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.Minutos))<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.CantidadEstandar*60))<BR>MinutosEnHoras(Suma(VentaDAgente:VentaDAgente.Minutos)-Suma(VentaDAgente:VentaDAgente.CantidadEstandar*60))
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Lista.VentaDAgente.Estado]
Carpeta=Lista
Clave=VentaDAgente.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaDAgente.FechaConclusion]
Carpeta=Lista
Clave=VentaDAgente.FechaConclusion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=5
ColorFondo=Plata
ColorFuente=Negro

[Lista.TiempoEstandar]
Carpeta=Lista
Clave=TiempoEstandar
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Gris

[(Carpeta Totalizadores).Tiempo]
Carpeta=(Carpeta Totalizadores)
Clave=Tiempo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Estándar]
Carpeta=(Carpeta Totalizadores)
Clave=Estándar
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Cantidad,  Conteo)
DespuesGuardar=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.VentaDAgente.Avance]
Carpeta=Lista
Clave=VentaDAgente.Avance
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaDAgente.Estado
VentaDAgente.Estado=VentaDAgente.Avance
VentaDAgente.Avance=VentaDAgente.FechaConclusion
VentaDAgente.FechaConclusion=VentaDAgente.Agente
VentaDAgente.Agente=VentaDAgente.Fecha
VentaDAgente.Fecha=VentaDAgente.HoraD
VentaDAgente.HoraD=VentaDAgente.HoraA
VentaDAgente.HoraA=Tiempo
Tiempo=TiempoEstandar
TiempoEstandar=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Tiempo
Tiempo=Estándar
Estándar=Diferencia
Diferencia=Conteo
Conteo=(Fin)
