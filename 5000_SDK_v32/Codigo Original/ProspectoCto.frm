[Forma]
Clave=ProspectoCto
Nombre=Contactos del Prospecto
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=295
PosicionInicialArriba=197
PosicionInicialAlturaProspecto=517
PosicionInicialAncho=849
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=54
PosicionInicialAlturaCliente=472
PosicionCol1=449

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
eMail=147
Grupo=128
Atencion=61
Tratamiento=65
NombreCompleto=268

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ProspectoCto
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

[Ficha.ProspectoCto.Nombre]
Carpeta=Ficha
Clave=ProspectoCto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.ProspectoCto.Cargo]
Carpeta=Ficha
Clave=ProspectoCto.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Grupo]
Carpeta=Ficha
Clave=ProspectoCto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Telefonos]
Carpeta=Ficha
Clave=ProspectoCto.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Extencion]
Carpeta=Ficha
Clave=ProspectoCto.Extencion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.eMail]
Carpeta=Ficha
Clave=ProspectoCto.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S

[Ficha.ProspectoCto.FechaNacimiento]
Carpeta=Ficha
Clave=ProspectoCto.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=S

[Ficha.ProspectoCto.Atencion]
Carpeta=Ficha
Clave=ProspectoCto.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Tratamiento]
Carpeta=Ficha
Clave=ProspectoCto.Tratamiento
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
Vista=ProspectoCto
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
FiltroGeneral=ProspectoCto.Prospecto=<T>{Info.Prospecto}<T>

[Lista.ProspectoCto.eMail]
Carpeta=Lista
Clave=ProspectoCto.eMail
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

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Anexos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>PCTO<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, ProspectoCto:ProspectoCto.ID)<BR>Asigna(Info.Descripcion, ProspectoCto:ProspectoCto.Nombre)
RefrescarDespues=S

[Ficha.ProspectoCto.Fax]
Carpeta=Ficha
Clave=ProspectoCto.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.PedirTono]
Carpeta=Ficha
Clave=ProspectoCto.PedirTono
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

[Ficha.ProspectoCto.ApellidoPaterno]
Carpeta=Ficha
Clave=ProspectoCto.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.ApellidoMaterno]
Carpeta=Ficha
Clave=ProspectoCto.ApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Tipo]
Carpeta=Ficha
Clave=ProspectoCto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ProspectoCto.Sexo]
Carpeta=Ficha
Clave=ProspectoCto.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N



[Ficha.ListaEnCaptura]
(Inicio)=ProspectoCto.Nombre
ProspectoCto.Nombre=ProspectoCto.ApellidoPaterno
ProspectoCto.ApellidoPaterno=ProspectoCto.ApellidoMaterno
ProspectoCto.ApellidoMaterno=ProspectoCto.eMail
ProspectoCto.eMail=ProspectoCto.Cargo
ProspectoCto.Cargo=ProspectoCto.Grupo
ProspectoCto.Grupo=ProspectoCto.Telefonos
ProspectoCto.Telefonos=ProspectoCto.Extencion
ProspectoCto.Extencion=ProspectoCto.Fax
ProspectoCto.Fax=ProspectoCto.PedirTono
ProspectoCto.PedirTono=ProspectoCto.FechaNacimiento
ProspectoCto.FechaNacimiento=ProspectoCto.Sexo
ProspectoCto.Sexo=ProspectoCto.Tipo
ProspectoCto.Tipo=ProspectoCto.Tratamiento
ProspectoCto.Tratamiento=ProspectoCto.Atencion
ProspectoCto.Atencion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=ProspectoCto.eMail
ProspectoCto.eMail=(Fin)

[Lista.ListaOrden]
(Inicio)=ProspectoCto.Nombre<TAB>(Acendente)
ProspectoCto.Nombre<TAB>(Acendente)=ProspectoCto.ApellidoPaterno<TAB>(Acendente)
ProspectoCto.ApellidoPaterno<TAB>(Acendente)=ProspectoCto.ApellidoMaterno<TAB>(Acendente)
ProspectoCto.ApellidoMaterno<TAB>(Acendente)=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Anexos
Anexos=Navegador
Navegador=(Fin)
