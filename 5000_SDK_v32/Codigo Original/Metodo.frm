[Forma]
Clave=Metodo
Nombre=Métodos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=384
PosicionInicialArriba=285
PosicionInicialAlturaCliente=427
PosicionInicialAncho=512
PosicionColumna1=34
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Metodo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.Metodo.Metodo]
Carpeta=Lista
Clave=Metodo.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Metodo.Metodo]
Carpeta=Ficha
Clave=Metodo.Metodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Metodo.Descripcion]
Carpeta=Ficha
Clave=Metodo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=50x10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Metodo=160
Nombre=322

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

[Acciones.Descripcion]
Nombre=Descripcion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Descripción
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
ClaveAccion=MetodoDescripcion
ConCondicion=S
EjecucionCondicion=ConDatos(Metodo:Metodo.Metodo)
Antes=S
AntesExpresiones=Asigna(Info.Clave, Metodo:Metodo.Metodo)

[Lista.Metodo.Nombre]
Carpeta=Lista
Clave=Metodo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Descripcion
Descripcion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Metodo.Metodo
Metodo.Metodo=Metodo.Nombre
Metodo.Nombre=(Fin)
