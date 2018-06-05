[Forma]
Clave=ProyResultado
Nombre=Resultados del Proyecto en MN
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=548
PosicionInicialArriba=361
PosicionInicialAlturaCliente=441
PosicionInicialAncho=823
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Proyecto, FechaEnTexto(SQL(<T>SELECT FechaProyResultado FROM Proy WHERE Proyecto=:tProyecto<T>, Info.Proyecto), <T>dd/mmm/aaaa hh:nn am/pm<T>))

[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyResultado
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido1=Real<BR>Presupuesto
FiltroPredefinido2=ProyResultado.Tipo=<T>Real<T><BR>ProyResultado.Tipo=<T>Presupuesto<T>
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Directorio
FiltroRespetar=S
FiltroTipo=Predefinido
CarpetaVisible=S
FiltroPredefinido3=ProyResultado.FechaEmision<BR>ProyResultado.FechaEmision
PestanaOtroNombre=S
PestanaNombre=Movimientos
IconosNombre=ProyResultado:ProyResultado.Mov+<T> <T>+ProyResultado:ProyResultado.MovID
FiltroGeneral=ProyResultado.Proyecto=<T>{Info.Proyecto}<T>

[Lista.ProyResultado.FechaEmision]
Carpeta=Lista
Clave=ProyResultado.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyResultado.Costo]
Carpeta=Lista
Clave=ProyResultado.Costo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ProyResultado.Gasto]
Carpeta=Lista
Clave=ProyResultado.Gasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ProyResultado.Venta]
Carpeta=Lista
Clave=ProyResultado.Venta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ProyResultado.Ingresos]
Carpeta=Lista
Clave=ProyResultado.Ingresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ProyResultado.Egresos]
Carpeta=Lista
Clave=ProyResultado.Egresos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Columnas]
0=138
1=103

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

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Recalc.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spProyResultado :tProyecto<T>, Info.Proyecto)
Activo=S
Visible=S

[Acciones.Recalc.Actualizar]
Nombre=Actualizar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Recalc]
Nombre=Recalc
Boton=92
NombreDesplegar=&Recalcular
Multiple=S
EnBarraHerramientas=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
ListaAccionesMultiples=Expresion<BR>Actualizar
Activo=S
Visible=S
EspacioPrevio=S
NombreEnBoton=S

[Acciones.MovProy]
Nombre=MovProy
Boton=25
NombreDesplegar=&Generar Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Dialogos
ClaveAccion=MovProy
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Mov, ConfigMov.InvEntradaDiversa)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(ProyResultado:ProyResultado.ModuloID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, ProyResultado:ProyResultado.Modulo)<BR>Asigna(Info.ID, ProyResultado:ProyResultado.ModuloID)
Visible=S

[Acciones.Capitalizar]
Nombre=Capitalizar
Boton=61
NombreDesplegar=Capitalizar Proyecto
EnBarraHerramientas=S
TipoAccion=Dialogos
ClaveAccion=CapProy
Activo=S
Visible=S
EspacioPrevio=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Propiedades
Propiedades=Recalc
Recalc=MovProy
MovProy=Capitalizar
Capitalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyResultado.FechaEmision
ProyResultado.FechaEmision=ProyResultado.Costo
ProyResultado.Costo=ProyResultado.Gasto
ProyResultado.Gasto=ProyResultado.Venta
ProyResultado.Venta=ProyResultado.Ingresos
ProyResultado.Ingresos=ProyResultado.Egresos
ProyResultado.Egresos=(Fin)
