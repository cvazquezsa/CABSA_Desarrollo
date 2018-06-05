[Forma]
Clave=PersonalDatosAcademicos
Icono=0
Modulos=(Todos)
Nombre=Datos Académicos del Personal
MovModulo=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=245
PosicionInicialAncho=596
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=402
PosicionInicialArriba=385
PosicionColumna1=31
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Personal
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalDatosAcademicos
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
ListaEnCaptura=PersonalDatosAcademicos.Nivel
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=PersonalDatosAcademicos.Personal = <T>{Info.Personal}<T>

[Lista.PersonalDatosAcademicos.Nivel]
Carpeta=Lista
Clave=PersonalDatosAcademicos.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalDatosAcademicos.Area]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Area
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalDatosAcademicos.Inicio]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Ficha.PersonalDatosAcademicos.Fin]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Fin
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10
Pegado=S

[Ficha.PersonalDatosAcademicos.Titulado]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Titulado
Editar=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Ficha.PersonalDatosAcademicos.Certificado]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Certificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.PersonalDatosAcademicos.IdiomaEscrito]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.IdiomaEscrito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Ficha.PersonalDatosAcademicos.IdiomaHablado]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.IdiomaHablado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Lista.Columnas]
Nivel=148
Titulo=240
Area=217
Inicio=64
Fin=64
Titulado=64
Certificado=124

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=PersonalDatosAcademicos
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

[Ficha.PersonalDatosAcademicos.Titulo]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

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
EspacioPrevio=S

[Ficha.PersonalDatosAcademicos.Nivel]
Carpeta=Ficha
Clave=PersonalDatosAcademicos.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
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
ClaveAccion=Registro Insertar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.PersonalTitulo]
Nombre=PersonalTitulo
Boton=47
NombreDesplegar=Títulos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PersonalTitulo
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=PersonalTitulo
PersonalTitulo=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=PersonalDatosAcademicos.Nivel
PersonalDatosAcademicos.Nivel=PersonalDatosAcademicos.Titulo
PersonalDatosAcademicos.Titulo=PersonalDatosAcademicos.Area
PersonalDatosAcademicos.Area=PersonalDatosAcademicos.Inicio
PersonalDatosAcademicos.Inicio=PersonalDatosAcademicos.Fin
PersonalDatosAcademicos.Fin=PersonalDatosAcademicos.Titulado
PersonalDatosAcademicos.Titulado=PersonalDatosAcademicos.Certificado
PersonalDatosAcademicos.Certificado=PersonalDatosAcademicos.IdiomaEscrito
PersonalDatosAcademicos.IdiomaEscrito=PersonalDatosAcademicos.IdiomaHablado
PersonalDatosAcademicos.IdiomaHablado=(Fin)
