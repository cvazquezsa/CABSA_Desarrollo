
[Forma]
Clave=POSUsuarioAccionLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=POS Acceso Usuarios
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Usuarios
CarpetaPrincipal=Usuarios
PosicionInicialAlturaCliente=437
PosicionInicialAncho=552
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=364
PosicionInicialArriba=147
ListaAcciones=(Lista)
[Usuarios]
Estilo=Iconos
Clave=Usuarios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Usuario
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(por Omisión)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
IconosSubTitulo=<T>Usuario<T>

IconosNombre=Usuario:Usuario.Usuario
[Usuarios.Usuario.Usuario]
Carpeta=Usuarios
Clave=Usuario.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Usuarios.Usuario.Nombre]
Carpeta=Usuarios
Clave=Usuario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Usuarios.Usuario.Sucursal]
Carpeta=Usuarios
Clave=Usuario.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Usuarios.Usuario.GrupoTrabajo]
Carpeta=Usuarios
Clave=Usuario.GrupoTrabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Usuarios.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2

5=-2

[Usuarios.Usuario.Departamento]
Carpeta=Usuarios
Clave=Usuario.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Acciones]
Nombre=Acciones
Boton=70
NombreEnBoton=S
NombreDesplegar=Acciones Permitidas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSUsuarioAccion
Activo=S
Visible=S

EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.Usuario, Usuario:Usuario.Usuario)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
















[Usuarios.ListaEnCaptura]
(Inicio)=Usuario.Usuario
Usuario.Usuario=Usuario.Nombre
Usuario.Nombre=Usuario.Sucursal
Usuario.Sucursal=Usuario.GrupoTrabajo
Usuario.GrupoTrabajo=Usuario.Departamento
Usuario.Departamento=(Fin)







[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Acciones
Acciones=(Fin)
