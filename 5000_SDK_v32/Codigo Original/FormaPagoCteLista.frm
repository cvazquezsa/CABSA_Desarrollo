
[Forma]
Clave=FormaPagoCteLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Forma de Pago del Cliente

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
CarpetaPrincipal=Lista
PosicionInicialIzquierda=322
PosicionInicialArriba=124
PosicionInicialAlturaCliente=290
PosicionInicialAncho=530
Comentarios=FormaPagoCte:Cliente
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoCte
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroGrupo1=Tipo
FiltroValida1=Tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S
[Lista.Sucursal]
Carpeta=Lista
Clave=Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.FormaPago]
Carpeta=Lista
Clave=FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Cuenta]
Carpeta=Lista
Clave=Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Seleccionar.Seleccion]
Nombre=Seleccion
Boton=0
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
NombreEnBoton=S


[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Seleccion
Seleccion=Aceptar
Aceptar=(Fin)

[Lista.Columnas]
Sucursal=71
FormaPago=125
Cuenta=85
Tipo=124









[Lista.ListaEnCaptura]
(Inicio)=Sucursal
Sucursal=FormaPago
FormaPago=Cuenta
Cuenta=(Fin)
