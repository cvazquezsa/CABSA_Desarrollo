[Forma]
Clave=AutoCorrida
Nombre=Corridas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=239
PosicionInicialArriba=300
PosicionInicialAlturaCliente=390
PosicionInicialAncho=802
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=41

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AutoCorrida
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
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroAplicaEn=AutoCorrida.Rol
FiltroPredefinido=S
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=AutoRol
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroEstilo=Lista (Abajo)
FiltroRespetar=S
FiltroTipo=Automático

[Lista.AutoCorrida.Corrida]
Carpeta=Lista
Clave=AutoCorrida.Corrida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AutoCorrida.Nombre]
Carpeta=Lista
Clave=AutoCorrida.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Corrida=106
Nombre=187
Hora=34
TipoServicio=304
Origen=304
Destino=304
Km=91

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

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=AutoCorrida
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

[Ficha.AutoCorrida.Corrida]
Carpeta=Ficha
Clave=AutoCorrida.Corrida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.AutoCorrida.Nombre]
Carpeta=Ficha
Clave=AutoCorrida.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Hora]
Carpeta=Ficha
Clave=AutoCorrida.Hora
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Origen]
Carpeta=Ficha
Clave=AutoCorrida.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.AutoCorrida.Destino]
Carpeta=Ficha
Clave=AutoCorrida.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
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

[Acciones.Plantilla]
Nombre=Plantilla
Boton=35
NombreEnBoton=S
NombreDesplegar=&Plantilla
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Antes=S
Visible=S
ClaveAccion=AutoCorridaPlantilla
GuardarAntes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(AutoCorrida:AutoCorrida.Corrida)
AntesExpresiones=Asigna(Info.Corrida, AutoCorrida:AutoCorrida.Corrida)<BR>Asigna(Info.Nombre, AutoCorrida:AutoCorrida.Nombre)<BR>Asigna(Info.Ruta, AutoCorrida:AutoCorrida.Ruta)

[Ficha.AutoCorrida.Servicio]
Carpeta=Ficha
Clave=AutoCorrida.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoOrigen.Nombre]
Carpeta=Ficha
Clave=AutoOrigen.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
OcultaNombre=S

[Ficha.AutoDestino.Nombre]
Carpeta=Ficha
Clave=AutoDestino.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
OcultaNombre=S

[Ficha.AutoCorrida.Kms]
Carpeta=Ficha
Clave=AutoCorrida.Kms
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Lts]
Carpeta=Ficha
Clave=AutoCorrida.Lts
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Rol]
Carpeta=Ficha
Clave=AutoCorrida.Rol
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Ruta]
Carpeta=Ficha
Clave=AutoCorrida.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoRuta.Nombre]
Carpeta=Ficha
Clave=AutoRuta.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
OcultaNombre=S

[Ficha.AutoCorrida.MantExterno]
Carpeta=Ficha
Clave=AutoCorrida.MantExterno
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Roles]
Nombre=Roles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Roles
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AutoCorridaRol
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(AutoCorrida:AutoCorrida.Corrida)
AntesExpresiones=Asigna(Info.Corrida, AutoCorrida:AutoCorrida.Corrida)<BR>Asigna(Info.Nombre, AutoCorrida:AutoCorrida.Nombre)<BR>Asigna(Info.Ruta, AutoCorrida:AutoCorrida.Ruta)
DespuesGuardar=S

[Ficha.AutoCorrida.Operador2]
Carpeta=Ficha
Clave=AutoCorrida.Operador2
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.AutoCorrida.Operador2Pct]
Carpeta=Ficha
Clave=AutoCorrida.Operador2Pct
Editar=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Registro Eliminar
Registro Eliminar=Roles
Roles=Plantilla
Plantilla=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AutoCorrida.Corrida
AutoCorrida.Corrida=AutoCorrida.Nombre
AutoCorrida.Nombre=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=AutoCorrida.Corrida
AutoCorrida.Corrida=AutoCorrida.Nombre
AutoCorrida.Nombre=AutoCorrida.Servicio
AutoCorrida.Servicio=AutoCorrida.Rol
AutoCorrida.Rol=AutoCorrida.Hora
AutoCorrida.Hora=AutoCorrida.Ruta
AutoCorrida.Ruta=AutoRuta.Nombre
AutoRuta.Nombre=AutoCorrida.Origen
AutoCorrida.Origen=AutoOrigen.Nombre
AutoOrigen.Nombre=AutoCorrida.Destino
AutoCorrida.Destino=AutoDestino.Nombre
AutoDestino.Nombre=AutoCorrida.Kms
AutoCorrida.Kms=AutoCorrida.Lts
AutoCorrida.Lts=AutoCorrida.MantExterno
AutoCorrida.MantExterno=AutoCorrida.Operador2
AutoCorrida.Operador2=AutoCorrida.Operador2Pct
AutoCorrida.Operador2Pct=(Fin)
