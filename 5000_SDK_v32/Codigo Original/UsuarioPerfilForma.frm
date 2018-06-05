
[Forma]
Clave=UsuarioPerfilForma
Icono=0
Modulos=(Todos)
Nombre=Perfiles (Formas)

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=473
PosicionInicialArriba=187
PosicionInicialAlturaCliente=358
PosicionInicialAncho=420
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioPerfilForma
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=UsuarioPerfilForma.Perfil
CarpetaVisible=S

[Lista.UsuarioPerfilForma.Perfil]
Carpeta=Lista
Clave=UsuarioPerfilForma.Perfil
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

[Lista.Columnas]
Perfil=383

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=UsuarioPerfilFormaD
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Perfil, UsuarioPerfilForma:UsuarioPerfilForma.Perfil)
Visible=S





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
