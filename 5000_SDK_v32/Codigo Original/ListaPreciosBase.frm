[Forma]
Clave=ListaPreciosBase
Nombre=Acceso - Precios Base
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=482
PosicionInicialArriba=383
PosicionInicialAltura=255
PosicionInicialAncho=316
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=230

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaPreciosBase
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
PermiteEditar=S
ListaEnCaptura=(Lista)
ListaOrden=ListaPreciosBase.Orden<TAB>(Acendente)

[Lista.ListaPreciosBase.Lista]
Carpeta=Lista
Clave=ListaPreciosBase.Lista
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ListaPreciosBase.NivelAcceso]
Carpeta=Lista
Clave=ListaPreciosBase.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Lista=86
NivelAcceso=200

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

[Lista.ListaEnCaptura]
(Inicio)=ListaPreciosBase.Lista
ListaPreciosBase.Lista=ListaPreciosBase.NivelAcceso
ListaPreciosBase.NivelAcceso=(Fin)
