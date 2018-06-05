[Forma]
Clave=FormaPagoD
Nombre=Denominaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=693
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=530
Comentarios=Info.FormaPago
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoD
Fuente={Tahoma, 8, Negro, []}
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoD.Denominacion<TAB>(Decendente)

FiltroGeneral=FormaPagoD.FormaPago=<T>{Info.FormaPago}<T>
[Lista.FormaPagoD.Denominacion]
Carpeta=Lista
Clave=FormaPagoD.Denominacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Denominacion=185

Nombre=304
[Lista.ListaEnCaptura]
(Inicio)=FormaPagoD.Denominacion
FormaPagoD.Denominacion=FormaPagoD.Nombre
FormaPagoD.Nombre=(Fin)

[Lista.FormaPagoD.Nombre]
Carpeta=Lista
Clave=FormaPagoD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
