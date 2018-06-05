[Forma]
Clave=SysVariable
Nombre=Variables
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=173
PosicionInicialArriba=128
PosicionInicialAltura=485
PosicionInicialAncho=644
PosicionColumna1=40
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SysVariable
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SysVariable.Variable
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.SysVariable.Variable]
Carpeta=Lista
Clave=SysVariable.Variable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
PestanaNombre=Detalles
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SysVariable
Fuente={MS Sans Serif, 8, Negro, []}
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

[Ficha.SysVariable.Variable]
Carpeta=Ficha
Clave=SysVariable.Variable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.Tipo]
Carpeta=Ficha
Clave=SysVariable.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.ValorInicial]
Carpeta=Ficha
Clave=SysVariable.ValorInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.Nombre]
Carpeta=Ficha
Clave=SysVariable.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.SysVariable.Tamano]
Carpeta=Ficha
Clave=SysVariable.Tamano
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.AyudaEnCaptura]
Carpeta=Ficha
Clave=SysVariable.AyudaEnCaptura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.Ayuda]
Carpeta=Ficha
Clave=SysVariable.Ayuda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SysVariable.Mayusculas]
Carpeta=Ficha
Clave=SysVariable.Mayusculas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.SysVariable.ListaOpciones]
Carpeta=Ficha
Clave=SysVariable.ListaOpciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=51x5
ConScroll=S

[Ficha.SysVariable.OpcionPredefinida]
Carpeta=Ficha
Clave=SysVariable.OpcionPredefinida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.SysVariable.UnicamenteOpciones]
Carpeta=Ficha
Clave=SysVariable.UnicamenteOpciones
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25

[Ficha.SysVariable.Validar]
Carpeta=Ficha
Clave=SysVariable.Validar
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Lista.Columnas]
Variable=223
Tipo=99

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=SysVariable.Variable
SysVariable.Variable=SysVariable.Tipo
SysVariable.Tipo=SysVariable.ValorInicial
SysVariable.ValorInicial=SysVariable.Nombre
SysVariable.Nombre=SysVariable.Tamano
SysVariable.Tamano=SysVariable.AyudaEnCaptura
SysVariable.AyudaEnCaptura=SysVariable.Ayuda
SysVariable.Ayuda=SysVariable.OpcionPredefinida
SysVariable.OpcionPredefinida=SysVariable.ListaOpciones
SysVariable.ListaOpciones=SysVariable.UnicamenteOpciones
SysVariable.UnicamenteOpciones=SysVariable.Validar
SysVariable.Validar=SysVariable.Mayusculas
SysVariable.Mayusculas=(Fin)
