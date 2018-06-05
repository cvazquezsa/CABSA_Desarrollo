
[Forma]
Clave=WebArtEnvoltura
Icono=0
Modulos=(Todos)
Nombre=Opciones Envoltura

ListaCarpetas=WebArtEnvoltura
CarpetaPrincipal=WebArtEnvoltura
PosicionInicialIzquierda=337
PosicionInicialArriba=288
PosicionInicialAlturaCliente=214
PosicionInicialAncho=711
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[WebArtEnvoltura]
Estilo=Hoja
Clave=WebArtEnvoltura
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtEnvoltura
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

[WebArtEnvoltura.WebArtEnvoltura.IDEnvoltura]
Carpeta=WebArtEnvoltura
Clave=WebArtEnvoltura.IDEnvoltura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[WebArtEnvoltura.WebEnvolturaRegalo.Nombre]
Carpeta=WebArtEnvoltura
Clave=WebEnvolturaRegalo.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[WebArtEnvoltura.Columnas]
IDEnvoltura=64
Nombre=604


[WebEnvolturaRegalo.Columnas]
Nombre=225
Precio=64
Visible=64
PermiteMensaje=80
Imagen=95
Articulo=124
SubCuenta=304

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S



EspacioPrevio=S









[WebArtEnvoltura.ListaEnCaptura]
(Inicio)=WebArtEnvoltura.IDEnvoltura
WebArtEnvoltura.IDEnvoltura=WebEnvolturaRegalo.Nombre
WebEnvolturaRegalo.Nombre=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
