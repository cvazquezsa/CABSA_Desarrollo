[Forma]
Clave=CtaEstructura
Nombre=<T>Cuentas de Estructura<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=342
PosicionInicialArriba=202
PosicionInicialAltura=364
PosicionInicialAncho=340

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaEstructura
Fuente={MS Sans Serif, 8, Negro, []}
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

[Lista.CtaEstructura.Cuenta]
Carpeta=Lista
Clave=CtaEstructura.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[Lista.CtaEstructura.Descripcion]
Carpeta=Lista
Clave=CtaEstructura.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

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

[Lista.Columnas]
Cuenta=79
Descripcion=232

[Lista.ListaEnCaptura]
(Inicio)=CtaEstructura.Cuenta
CtaEstructura.Cuenta=CtaEstructura.Descripcion
CtaEstructura.Descripcion=(Fin)
