[Forma]
Clave=CxpFusionar
Nombre=Fusionar - Cuentas por Pagar
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=380
PosicionInicialArriba=335
PosicionInicialAlturaProveedor=62
PosicionInicialAncho=268
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Proveedor, Nulo)
PosicionInicialAlturaCliente=68

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Proveedor
CarpetaVisible=S

[(Variables).Info.Proveedor]
Carpeta=(Variables)
Clave=Info.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Fusionar]
Nombre=Fusionar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Fusionar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion
EspacioPrevio=S

[Acciones.Fusionar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Fusionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=ProcesarSQL(<T>spFusionarCx :tEmpresa, :tUsuario, :nSucursal, :tModulo, :fFecha, :tContacto, :tCxMov<T>, Empresa, Usuario, Sucursal, <T>CXP<T>, FechaTrabajo, Info.Proveedor, ConfigMov.CxpDocumento)
EjecucionCondicion=ConDatos(Info.Proveedor)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Fusionar
Fusionar=(Fin)
