[Forma]
Clave=MenuAccion
Nombre=Acciones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=554
PosicionInicialArriba=316
PosicionInicialAlturaCliente=531
PosicionInicialAncho=811
PosicionCol1=424
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
Vista=MenuAccion
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
HojaMantenerSeleccion=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaAjustarColumnas=S

[Lista.MenuAccion.Accion]
Carpeta=Lista
Clave=MenuAccion.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MenuAccion.Nombre]
Carpeta=Lista
Clave=MenuAccion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Accion=171
Nombre=221

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MenuAccion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.MenuAccion.Accion]
Carpeta=Ficha
Clave=MenuAccion.Accion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=34
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuAccion.Nombre]
Carpeta=Ficha
Clave=MenuAccion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=34
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuAccion.Descripcion]
Carpeta=Ficha
Clave=MenuAccion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x3
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.MenuAccion.Visible]
Carpeta=Ficha
Clave=MenuAccion.Visible
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50
EspacioPrevio=S

[Ficha.MenuAccion.VisibleCondicion]
Carpeta=Ficha
Clave=MenuAccion.VisibleCondicion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50x5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuAccion.Activo]
Carpeta=Ficha
Clave=MenuAccion.Activo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=50
EspacioPrevio=S

[Ficha.MenuAccion.ActivoCondicion]
Carpeta=Ficha
Clave=MenuAccion.ActivoCondicion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=50x5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuAccion.Expresion]
Carpeta=Ficha
Clave=MenuAccion.Expresion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50x5
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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Ficha.MenuAccion.Imagen]
Carpeta=Ficha
Clave=MenuAccion.Imagen
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuAccion.Estatus]
Carpeta=Ficha
Clave=MenuAccion.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MenuAccion.Accion
MenuAccion.Accion=MenuAccion.Nombre
MenuAccion.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MenuAccion.Accion
MenuAccion.Accion=MenuAccion.Estatus
MenuAccion.Estatus=MenuAccion.Nombre
MenuAccion.Nombre=MenuAccion.Imagen
MenuAccion.Imagen=MenuAccion.Expresion
MenuAccion.Expresion=MenuAccion.Descripcion
MenuAccion.Descripcion=MenuAccion.Visible
MenuAccion.Visible=MenuAccion.VisibleCondicion
MenuAccion.VisibleCondicion=MenuAccion.Activo
MenuAccion.Activo=MenuAccion.ActivoCondicion
MenuAccion.ActivoCondicion=(Fin)
