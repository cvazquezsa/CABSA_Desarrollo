
[Forma]
Clave=MFATipoCta
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
Nombre=MFA - Configuración tipos de cuenta
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=221
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registros
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoCta
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
[Lista.ListaEnCaptura]
(Inicio)=MFATipoCta.Cuenta
MFATipoCta.Cuenta=MFATipoCta.Tipo
MFATipoCta.Tipo=MFATipoCta.SubTipo
MFATipoCta.SubTipo=(Fin)

[Lista.MFATipoCta.Cuenta]
Carpeta=Lista
Clave=MFATipoCta.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCta.Tipo]
Carpeta=Lista
Clave=MFATipoCta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCta.SubTipo]
Carpeta=Lista
Clave=MFATipoCta.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Cuenta=128
Tipo=143
SubTipo=188
