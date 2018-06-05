[Forma]
Clave=CxcFusionar
Nombre=Fusionar - Cuentas por Cobrar
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=508
PosicionInicialArriba=467
PosicionInicialAlturaCliente=67
PosicionInicialAncho=268
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)

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
ListaEnCaptura=Info.Cliente
CarpetaVisible=S

[(Variables).Info.Cliente]
Carpeta=(Variables)
Clave=Info.Cliente
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
Expresion=ProcesarSQL(<T>spFusionarCx :tEmpresa, :tUsuario, :nSucursal, :tModulo, :fFecha, :tContacto, :tCxMov<T>, Empresa, Usuario, Sucursal, <T>CXC<T>, FechaTrabajo, Info.Cliente, ConfigMov.CxcDocumento)
EjecucionCondicion=ConDatos(Info.Cliente)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Fusionar
Fusionar=(Fin)
