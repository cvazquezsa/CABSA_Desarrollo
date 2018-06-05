[Forma]
Clave=FormaPagoTipo
Nombre=Tipos Formas Pagos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=750
PosicionInicialArriba=358
PosicionInicialAlturaCliente=448
PosicionInicialAncho=429
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
Vista=FormaPagoTipo
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
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.FormaPagoTipo.Tipo]
Carpeta=Lista
Clave=FormaPagoTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(FormaPagoTipo:FormaPagoTipo.Tipo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Tipo=312
SobrePrecio=78

[Acciones.FormasPago]
Nombre=FormasPago
Boton=47
NombreEnBoton=S
NombreDesplegar=&Formas Pago
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FormaPagoTipoD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(FormaPagoTipo:FormaPagoTipo.Tipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, FormaPagoTipo:FormaPagoTipo.Tipo)
Visible=S

[Lista.FormaPagoTipo.SobrePrecio]
Carpeta=Lista
Clave=FormaPagoTipo.SobrePrecio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=FormasPago
FormasPago=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=FormaPagoTipo.Tipo
FormaPagoTipo.Tipo=FormaPagoTipo.SobrePrecio
FormaPagoTipo.SobrePrecio=(Fin)
