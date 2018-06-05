
[Forma]
Clave=NOITipoEmpleado
Icono=0
CarpetaPrincipal=NOITipoEmpleado
Modulos=(Todos)
Nombre=Tipos Personal
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=NOITipoEmpleado
PosicionInicialIzquierda=647
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=306
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

[NOITipoEmpleado]
Estilo=Hoja
Clave=NOITipoEmpleado
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOITipoEmpleado
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

[NOITipoEmpleado.NOITipoEmpleado.TipoEmpleadoNOI]
Carpeta=NOITipoEmpleado
Clave=NOITipoEmpleado.TipoEmpleadoNOI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOITipoEmpleado.NOITipoEmpleado.Tipo]
Carpeta=NOITipoEmpleado
Clave=NOITipoEmpleado.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOITipoEmpleado.ListaEnCaptura]
(Inicio)=NOITipoEmpleado.TipoEmpleadoNOI
NOITipoEmpleado.TipoEmpleadoNOI=NOITipoEmpleado.Tipo
NOITipoEmpleado.Tipo=(Fin)

[NOITipoEmpleado.Columnas]
TipoEmpleadoNOI=124
Tipo=124
