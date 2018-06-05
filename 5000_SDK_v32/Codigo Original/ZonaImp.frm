[Forma]
Clave=ZonaImp
Nombre=Zonas de Impuestos Especiales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=445
PosicionInicialArriba=389
PosicionInicialAltura=238
PosicionInicialAncho=390
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialAlturaCliente=211

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=Si
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=ZonaImp
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=Si
HojaMostrarColumnas=Si
HojaMostrarRenglones=Si
HojaColoresPorEstatus=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
HojaConfirmarEliminar=Si
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=Si

[Lista.ZonaImp.Zona]
Carpeta=Lista
Clave=ZonaImp.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Lista.ZonaImp.Impuesto]
Carpeta=Lista
Clave=ZonaImp.Impuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Zona=139
Impuesto=113
Porcentaje=106

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=Si
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraHerramientas=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=Si
Activo=Si

[Lista.ZonaImp.Porcentaje]
Carpeta=Lista
Clave=ZonaImp.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.ListaEnCaptura]
(Inicio)=ZonaImp.Zona
ZonaImp.Zona=ZonaImp.Impuesto
ZonaImp.Impuesto=ZonaImp.Porcentaje
ZonaImp.Porcentaje=(Fin)
