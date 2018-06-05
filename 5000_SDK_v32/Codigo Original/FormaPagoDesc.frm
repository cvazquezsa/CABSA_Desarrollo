[Forma]
Clave=FormaPagoDesc
Nombre=Descuentos por Forma Pago (PV)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=379
PosicionInicialArriba=177
PosicionInicialAlturaCliente=379
PosicionInicialAncho=265
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
Vista=FormaPagoDesc
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
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=FormaPagoDesc.FormaPago=<T>{Info.FormaPago}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.FormaPagoDesc.ListaPreciosEsp]
Carpeta=Lista
Clave=FormaPagoDesc.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FormaPagoDesc.Descuento]
Carpeta=Lista
Clave=FormaPagoDesc.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
ListaPreciosEsp=150
Descuento=85

[Lista.ListaEnCaptura]
(Inicio)=FormaPagoDesc.ListaPreciosEsp
FormaPagoDesc.ListaPreciosEsp=FormaPagoDesc.Descuento
FormaPagoDesc.Descuento=(Fin)
