[Forma]
Clave=EmpresaCfgPVMonCta
Nombre=Configuración Corte Multimoneda
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Empresa
PosicionInicialIzquierda=330
PosicionInicialArriba=285
PosicionInicialAlturaCliente=419
PosicionInicialAncho=619
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgPVMonCta
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

[Lista.EmpresaCfgPVMonCta.Moneda]
Carpeta=Lista
Clave=EmpresaCfgPVMonCta.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgPVMonCta.FormaPago]
Carpeta=Lista
Clave=EmpresaCfgPVMonCta.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgPVMonCta.Usuario]
Carpeta=Lista
Clave=EmpresaCfgPVMonCta.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgPVMonCta.CuentaCorteParcial]
Carpeta=Lista
Clave=EmpresaCfgPVMonCta.CuentaCorteParcial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgPVMonCta.CuentaCorteCaja]
Carpeta=Lista
Clave=EmpresaCfgPVMonCta.CuentaCorteCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
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
Moneda=77
FormaPago=193
Usuario=110
CuentaCorteParcial=108
CuentaCorteCaja=98

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgPVMonCta.Moneda
EmpresaCfgPVMonCta.Moneda=EmpresaCfgPVMonCta.FormaPago
EmpresaCfgPVMonCta.FormaPago=EmpresaCfgPVMonCta.Usuario
EmpresaCfgPVMonCta.Usuario=EmpresaCfgPVMonCta.CuentaCorteParcial
EmpresaCfgPVMonCta.CuentaCorteParcial=EmpresaCfgPVMonCta.CuentaCorteCaja
EmpresaCfgPVMonCta.CuentaCorteCaja=(Fin)
