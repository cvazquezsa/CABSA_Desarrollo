
[Forma]
Clave=MFACuentasEspeciales
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=MFA - Cuentas Especiales

ListaCarpetas=MFACuentasEspeciales
CarpetaPrincipal=MFACuentasEspeciales
PosicionInicialIzquierda=387
PosicionInicialArriba=205
PosicionInicialAlturaCliente=273
PosicionInicialAncho=470
PosicionSec1=330
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
BarraHerramientas=S
[MFACuentasEspeciales]
Estilo=Hoja
Clave=MFACuentasEspeciales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFACuentasEspeciales
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

[MFACuentasEspeciales.MFACuentasEspeciales.Cuenta]
Carpeta=MFACuentasEspeciales
Clave=MFACuentasEspeciales.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[MFACuentasEspeciales.Cta.Descripcion]
Carpeta=MFACuentasEspeciales
Clave=Cta.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Clave=140
Descripcion=303

0=207
[MFACuentasEspeciales.Columnas]
Cuenta=124
Descripcion=304


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S





[MFACuentasEspeciales.ListaEnCaptura]
(Inicio)=MFACuentasEspeciales.Cuenta
MFACuentasEspeciales.Cuenta=Cta.Descripcion
Cta.Descripcion=(Fin)
