

[Forma]
Clave=MovilFormaPago
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Formas de Cobro

ListaCarpetas=Lista
PosicionInicialIzquierda=676
PosicionInicialArriba=300
PosicionInicialAlturaCliente=273
PosicionInicialAncho=344
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovilFormaPago
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
ListaEnCaptura=MovilFormaPago.FormaPago

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=Empresa ={Comillas(Empresa)}
[Lista.ListaEnCaptura]
(Inicio)=MovilFormaPago.Empresa
MovilFormaPago.Empresa=MovilFormaPago.FormaPago
MovilFormaPago.FormaPago=(Fin)


[Lista.MovilFormaPago.FormaPago]
Carpeta=Lista
Clave=MovilFormaPago.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Empresa=45
FormaPago=304

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
