[Forma]
Clave=MovCto
Nombre=Contactos del Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=539
PosicionInicialArriba=342
PosicionInicialAlturaCliente=482
PosicionInicialAncho=841
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=54
PosicionCol1=449
Comentarios=Lista(Info.Mov, Info.MovID)

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
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
Nombre=185
Cargo=97
FechaNacimiento=88
Telefonos=102
Extencion=51
eMail=149
Grupo=128
Atencion=61
Tratamiento=65
NombreCompleto=268

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreDesplegar=&Grupos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovCtoGrupo
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovCto
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

[Ficha.MovCto.Nombre]
Carpeta=Ficha
Clave=MovCto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.MovCto.Cargo]
Carpeta=Ficha
Clave=MovCto.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Grupo]
Carpeta=Ficha
Clave=MovCto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Telefonos]
Carpeta=Ficha
Clave=MovCto.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Extencion]
Carpeta=Ficha
Clave=MovCto.Extencion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.eMail]
Carpeta=Ficha
Clave=MovCto.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S

[Ficha.MovCto.FechaNacimiento]
Carpeta=Ficha
Clave=MovCto.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=S

[Ficha.MovCto.Atencion]
Carpeta=Ficha
Clave=MovCto.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Tratamiento]
Carpeta=Ficha
Clave=MovCto.Tratamiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovCto
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=MovCto.Modulo=<T>{Info.Modulo}<T> AND MovCto.ModuloID={Info.ID}

[Lista.MovCto.eMail]
Carpeta=Lista
Clave=MovCto.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
EspacioPrevio=S

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

[Ficha.MovCto.Fax]
Carpeta=Ficha
Clave=MovCto.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.PedirTono]
Carpeta=Ficha
Clave=MovCto.PedirTono
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NombreCompleto]
Carpeta=Lista
Clave=NombreCompleto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=200
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.ApellidoPaterno]
Carpeta=Ficha
Clave=MovCto.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.ApellidoMaterno]
Carpeta=Ficha
Clave=MovCto.ApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Tipo]
Carpeta=Ficha
Clave=MovCto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovCto.Sexo]
Carpeta=Ficha
Clave=MovCto.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N



[Ficha.ListaEnCaptura]
(Inicio)=MovCto.Nombre
MovCto.Nombre=MovCto.ApellidoPaterno
MovCto.ApellidoPaterno=MovCto.ApellidoMaterno
MovCto.ApellidoMaterno=MovCto.eMail
MovCto.eMail=MovCto.Cargo
MovCto.Cargo=MovCto.Grupo
MovCto.Grupo=MovCto.Telefonos
MovCto.Telefonos=MovCto.Extencion
MovCto.Extencion=MovCto.Fax
MovCto.Fax=MovCto.PedirTono
MovCto.PedirTono=MovCto.FechaNacimiento
MovCto.FechaNacimiento=MovCto.Sexo
MovCto.Sexo=MovCto.Tipo
MovCto.Tipo=MovCto.Tratamiento
MovCto.Tratamiento=MovCto.Atencion
MovCto.Atencion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=MovCto.eMail
MovCto.eMail=(Fin)

[Lista.ListaOrden]
(Inicio)=MovCto.Nombre<TAB>(Acendente)
MovCto.Nombre<TAB>(Acendente)=MovCto.ApellidoPaterno<TAB>(Acendente)
MovCto.ApellidoPaterno<TAB>(Acendente)=MovCto.ApellidoMaterno<TAB>(Acendente)
MovCto.ApellidoMaterno<TAB>(Acendente)=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Grupos
Grupos=Navegador
Navegador=(Fin)
