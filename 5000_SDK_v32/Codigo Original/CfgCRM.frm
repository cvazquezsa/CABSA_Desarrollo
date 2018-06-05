
[Forma]
Clave=CfgCRM
Icono=0
Modulos=(Todos)
Nombre=Configuración CRM

ListaCarpetas=Ficha
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=123
PosicionInicialArriba=357
PosicionInicialAlturaCliente=118
PosicionInicialAncho=554
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgCRM
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Ficha.CfgCRM.ServidorIntelisis]
Carpeta=Ficha
Clave=CfgCRM.ServidorIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco

[Ficha.CfgCRM.BaseIntelisis]
Carpeta=Ficha
Clave=CfgCRM.BaseIntelisis
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco

[Ficha.CfgCRM.Usuario]
Carpeta=Ficha
Clave=CfgCRM.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.CfgCRM.Contrasena]
Carpeta=Ficha
Clave=CfgCRM.Contrasena
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=32
ColorFondo=Blanco








[Lista.Columnas]
0=99
1=375









[Ficha.ListaEnCaptura]
(Inicio)=CfgCRM.ServidorIntelisis
CfgCRM.ServidorIntelisis=CfgCRM.BaseIntelisis
CfgCRM.BaseIntelisis=CfgCRM.Usuario
CfgCRM.Usuario=CfgCRM.Contrasena
CfgCRM.Contrasena=(Fin)

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
