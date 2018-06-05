[Forma]
Clave=Excel                      
Nombre=Plantillas Excel
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=249
PosicionInicialArriba=309
PosicionInicialAltura=406
PosicionInicialAncho=781
PosicionColumna1=38
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
PosicionInicialAlturaCliente=379
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Excel
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Excel.Plantilla
CarpetaVisible=S
Filtros=S
FiltroAplicaEn=Excel.Tipo
FiltroPredefinido=S
FiltroAutoCampo=Excel.Tipo
FiltroAutoValidar=Excel.Tipo
FiltroNullNombre=(Otras)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=15
FiltroRespetar=S
FiltroTipo=Automático
HojaMantenerSeleccion=S
FiltroGrupo1=Excel.Categoria
FiltroGrupo2=Excel.Tipo
FiltroEstilo=Lista (Arriba)
FiltroTodo=S

[Lista.Excel.Plantilla]
Carpeta=Lista
Clave=Excel.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Plantilla=262

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
EnMenu=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Excel:Excel.Plantilla)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
EnMenu=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S
Menu=&Archivo
EnMenu=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Omision.Excel.Cliente]
Carpeta=Omision
Clave=Excel.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Cte.Nombre]
Carpeta=Omision
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Omision.Excel.EnviarA]
Carpeta=Omision
Clave=Excel.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Omision.CteEnviarA.Nombre]
Carpeta=Omision
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Categorias]
Nombre=Categorias
Boton=91
NombreEnBoton=S
NombreDesplegar=Categorías
TipoAccion=Formas
ClaveAccion=ExcelCat
Activo=S
Visible=S
EspacioPrevio=S
Menu=&Maestros
EnMenu=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Omision.Excel.Almacen]
Carpeta=Omision
Clave=Excel.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Plantilla
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Excel
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.Excel.Plantilla]
Carpeta=Detalle
Clave=Excel.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Excel.Tipo]
Carpeta=Detalle
Clave=Excel.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Excel.Categoria]
Carpeta=Detalle
Clave=Excel.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Omision.Excel.Plantilla]
Carpeta=Omision
Clave=Excel.Plantilla
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Omision.Excel.Categoria]
Carpeta=Omision
Clave=Excel.Categoria
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=32
ColorFondo=Plata
ColorFuente=Negro

[Omision.Excel.Tipo]
Carpeta=Omision
Clave=Excel.Tipo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=32
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Excel.Cliente]
Carpeta=Detalle
Clave=Excel.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Excel.EnviarA]
Carpeta=Detalle
Clave=Excel.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Nombre]
Carpeta=Detalle
Clave=CteEnviarA.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Excel.Almacen]
Carpeta=Detalle
Clave=Excel.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Excel.Mov]
Carpeta=Detalle
Clave=Excel.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Cfg]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Configuración
Clave=Cfg
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Excel
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Cfg.Excel.Plantilla]
Carpeta=Cfg
Clave=Excel.Plantilla
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Plata
ColorFuente=Negro

[Cfg.Excel.StoredProcedure]
Carpeta=Cfg
Clave=Excel.StoredProcedure
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cfg.Excel.Direccion]
Carpeta=Cfg
Clave=Excel.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Cfg.Excel.RenglonesDetalle]
Carpeta=Cfg
Clave=Excel.RenglonesDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
Menu=&Edición
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExcelD
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(Excel:Excel.Plantilla)
AntesExpresiones=Asigna(Info.Clave, Excel:Excel.Plantilla)<BR>Asigna(Info.Tipo, Excel:Excel.Direccion)

[Detalle.Excel.Moneda]
Carpeta=Detalle
Clave=Excel.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Cfg
Cfg=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Campos
Campos=Categorias
Categorias=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Maestros
&Maestros=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Excel.Plantilla
Excel.Plantilla=Excel.Tipo
Excel.Tipo=Excel.Categoria
Excel.Categoria=Excel.Mov
Excel.Mov=Excel.Moneda
Excel.Moneda=Excel.Cliente
Excel.Cliente=Cte.Nombre
Cte.Nombre=Excel.EnviarA
Excel.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Excel.Almacen
Excel.Almacen=(Fin)

[Cfg.ListaEnCaptura]
(Inicio)=Excel.Plantilla
Excel.Plantilla=Excel.StoredProcedure
Excel.StoredProcedure=Excel.Direccion
Excel.Direccion=Excel.RenglonesDetalle
Excel.RenglonesDetalle=(Fin)
