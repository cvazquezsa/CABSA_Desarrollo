[Forma]
Clave=WebPais
Nombre=Países
Icono=0
CarpetaPrincipal=WebPais
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=WebPais
PosicionInicialIzquierda=571
PosicionInicialArriba=225
PosicionInicialAlturaCliente=372
PosicionInicialAncho=458
ListaAcciones=(Lista)
[WebPais]
Estilo=Hoja
Clave=WebPais
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebPais
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
PermiteEditar=S
ListaEnCaptura=WebPais.Nombre
[WebPais.WebPais.Nombre]
Carpeta=WebPais
Clave=WebPais.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
[WebPais.Columnas]
Nombre=230
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
[Acciones.WebPaisEstado]
Nombre=WebPaisEstado
Boton=0
NombreEnBoton=S
NombreDesplegar=Estados
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S






























Antes=S
DespuesGuardar=S
Expresion=Asigna(Info.Origen,WebPais:WebPais.Nombre)<BR>GuardarCambios<BR>Asigna(Info.ID,SQL(<T>SELECT ID FROM WebPais WHERE Nombre = :tNombre<T>,WebPais:WebPais.Nombre))    <BR>FormaModal(<T>WebPaisEstado<T>)
[WebPaisEstado.Columnas]
Nombre=419























































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=WebPaisEstado
WebPaisEstado=(Fin)
