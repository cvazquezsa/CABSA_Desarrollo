[Forma]
Clave=AutoRol
Nombre=Roles
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=354
PosicionInicialArriba=136
PosicionInicialAlturaCliente=462
PosicionInicialAncho=316
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoRol
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
OtroOrden=S
ListaOrden=AutoRol.Clave<TAB>(Acendente)
HojaMantenerSeleccion=S

[Lista.AutoRol.Rol]
Carpeta=Lista
Clave=AutoRol.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Rol=244
Nombre=336
Clave=42

[Lista.AutoRol.Clave]
Carpeta=Lista
Clave=AutoRol.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=2
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CargosFijos]
Nombre=CargosFijos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Cargos Fijos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AutoRolCargo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(AutoRol:AutoRol.Rol)
AntesExpresiones=Asigna(Info.Rol, AutoRol:AutoRol.Rol)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CargosFijos
CargosFijos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoRol.Clave
AutoRol.Clave=AutoRol.Rol
AutoRol.Rol=(Fin)
