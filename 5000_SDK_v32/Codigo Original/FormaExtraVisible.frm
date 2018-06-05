[Forma]
Clave=FormaExtraVisible
Nombre=Visibilidad
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.FormaTipo
PosicionInicialIzquierda=380
PosicionInicialArriba=170
PosicionInicialAlturaCliente=349
PosicionInicialAncho=606
PosicionCol1=176
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraVisible
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=FormaExtraVisible.Aplica
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=FormaExtraVisible.FormaTipo=<T>{Info.FormaTipo}<T>

[Lista.FormaExtraVisible.Aplica]
Carpeta=Lista
Clave=FormaExtraVisible.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=FormaExtraVisible
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

[Ficha.FormaExtraVisible.Aplica]
Carpeta=Ficha
Clave=FormaExtraVisible.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.Modulo]
Carpeta=Ficha
Clave=FormaExtraVisible.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.Movimiento]
Carpeta=Ficha
Clave=FormaExtraVisible.Movimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.Categoria]
Carpeta=Ficha
Clave=FormaExtraVisible.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.FormaExtraVisible.Grupo]
Carpeta=Ficha
Clave=FormaExtraVisible.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.Familia]
Carpeta=Ficha
Clave=FormaExtraVisible.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.Departamento]
Carpeta=Ficha
Clave=FormaExtraVisible.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.FormaExtraVisible.Puesto]
Carpeta=Ficha
Clave=FormaExtraVisible.Puesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.SIC]
Carpeta=Ficha
Clave=FormaExtraVisible.SIC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
EspacioPrevio=S

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
Aplica=146

0=118
1=311
[Ficha.SIC.Nombre]
Carpeta=Ficha
Clave=SIC.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata

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
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S



[Lista.ListaOrden]
(Inicio)=FormaExtraVisible.Aplica<TAB>(Acendente)
FormaExtraVisible.Aplica<TAB>(Acendente)=FormaExtraVisible.Modulo<TAB>(Acendente)
FormaExtraVisible.Modulo<TAB>(Acendente)=FormaExtraVisible.Movimiento<TAB>(Acendente)
FormaExtraVisible.Movimiento<TAB>(Acendente)=FormaExtraVisible.Categoria<TAB>(Acendente)
FormaExtraVisible.Categoria<TAB>(Acendente)=FormaExtraVisible.Grupo<TAB>(Acendente)
FormaExtraVisible.Grupo<TAB>(Acendente)=FormaExtraVisible.Familia<TAB>(Acendente)
FormaExtraVisible.Familia<TAB>(Acendente)=FormaExtraVisible.Departamento<TAB>(Acendente)
FormaExtraVisible.Departamento<TAB>(Acendente)=FormaExtraVisible.Puesto<TAB>(Acendente)
FormaExtraVisible.Puesto<TAB>(Acendente)=FormaExtraVisible.SIC<TAB>(Acendente)
FormaExtraVisible.SIC<TAB>(Acendente)=(Fin)




[Ficha.FormaExtraVisible.Uso]
Carpeta=Ficha
Clave=FormaExtraVisible.Uso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Ficha.FormaExtraVisible.TipoInmueble]
Carpeta=Ficha
Clave=FormaExtraVisible.TipoInmueble
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco



[Ficha.ListaEnCaptura]
(Inicio)=FormaExtraVisible.FormaTipo
FormaExtraVisible.FormaTipo=FormaExtraVisible.Aplica
FormaExtraVisible.Aplica=FormaExtraVisible.Modulo
FormaExtraVisible.Modulo=FormaExtraVisible.Movimiento
FormaExtraVisible.Movimiento=FormaExtraVisible.Categoria
FormaExtraVisible.Categoria=FormaExtraVisible.Grupo
FormaExtraVisible.Grupo=FormaExtraVisible.Familia
FormaExtraVisible.Familia=FormaExtraVisible.Departamento
FormaExtraVisible.Departamento=FormaExtraVisible.Puesto
FormaExtraVisible.Puesto=FormaExtraVisible.Uso
FormaExtraVisible.Uso=FormaExtraVisible.SIC
FormaExtraVisible.SIC=SIC.Nombre
SIC.Nombre=FormaExtraVisible.TipoInmueble
FormaExtraVisible.TipoInmueble=(Fin)

[Ficha.FormaExtraVisible.FormaTipo]
Carpeta=Ficha
Clave=FormaExtraVisible.FormaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco





[(Carpeta Abrir).Columnas]
0=124
1=255
2=-2





























[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
