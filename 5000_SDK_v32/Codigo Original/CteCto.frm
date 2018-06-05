[Forma]
Clave=CteCto
Nombre=Contactos del Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=250
PosicionInicialArriba=65
PosicionInicialAlturaCliente=560
PosicionInicialAncho=866
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=54
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

[Acciones.Cargo]
Nombre=Cargo
Boton=50
NombreEnBoton=S
NombreDesplegar=&Cargos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Cargo
Activo=S
Visible=S

[Acciones.Grupos]
Nombre=Grupos
Boton=91
NombreDesplegar=&Grupos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCtoGrupo
Activo=S
Visible=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CteCto
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

[Ficha.CteCto.Nombre]
Carpeta=Ficha
Clave=CteCto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.CteCto.Cargo]
Carpeta=Ficha
Clave=CteCto.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Grupo]
Carpeta=Ficha
Clave=CteCto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Telefonos]
Carpeta=Ficha
Clave=CteCto.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Extencion]
Carpeta=Ficha
Clave=CteCto.Extencion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.eMail]
Carpeta=Ficha
Clave=CteCto.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=S

[Ficha.CteCto.FechaNacimiento]
Carpeta=Ficha
Clave=CteCto.FechaNacimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=S

[Ficha.CteCto.Atencion]
Carpeta=Ficha
Clave=CteCto.Atencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Tratamiento]
Carpeta=Ficha
Clave=CteCto.Tratamiento
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
Vista=CteCto
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
FiltroGeneral=CteCto.Cliente=<T>{Info.Cliente}<T>

[Lista.CteCto.eMail]
Carpeta=Lista
Clave=CteCto.eMail
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

[Acciones.Comites]
Nombre=Comites
Boton=47
NombreEnBoton=S
NombreDesplegar=Co&mités
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteCtoComites
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Cliente, CteCto:CteCto.Cliente)<BR>Asigna(Info.ID, CteCto:CteCto.ID)<BR>Asigna(Info.Nombre, CteCto:CteCto.Nombre)

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
AntesExpresiones=Asigna(Info.Rama, <T>CTO<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, CteCto:CteCto.ID)<BR>Asigna(Info.Descripcion, CteCto:CteCto.Nombre)
RefrescarDespues=S

[Acciones.Direcciones]
Nombre=Direcciones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Direcciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCtoDireccion
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Cliente, CteCto:CteCto.Cliente)<BR>Asigna(Info.ID, CteCto:CteCto.ID)<BR>Asigna(Info.Nombre, CteCto:CteCto.Nombre)

[Ficha.CteCto.Fax]
Carpeta=Ficha
Clave=CteCto.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.PedirTono]
Carpeta=Ficha
Clave=CteCto.PedirTono
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Actividades]
Nombre=Actividades
Boton=47
NombreEnBoton=S
NombreDesplegar=&Actividades
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCtoActividad
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Cliente, CteCto:CteCto.Cliente)<BR>Asigna(Info.ID, CteCto:CteCto.ID)<BR>Asigna(Info.Nombre, CteCto:CteCto.Nombre)

[Ficha.CteCto.EnviarA]
Carpeta=Ficha
Clave=CteCto.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

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

[Ficha.CteCto.ApellidoPaterno]
Carpeta=Ficha
Clave=CteCto.ApellidoPaterno
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.ApellidoMaterno]
Carpeta=Ficha
Clave=CteCto.ApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Tipo]
Carpeta=Ficha
Clave=CteCto.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CteCto.Sexo]
Carpeta=Ficha
Clave=CteCto.Sexo
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Acciones.Eventos]
Nombre=Eventos
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ventos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCtoEvento
Activo=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Cliente, CteCto:CteCto.Cliente)<BR>Asigna(Info.ID, CteCto:CteCto.ID)<BR>Asigna(Info.Nombre, CteCto:CteCto.Nombre)

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreDesplegar=Histórico de Cambios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteCtoHist
Activo=S
Visible=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Cliente, CteCto:CteCto.Cliente)<BR>Asigna(Info.ID, CteCto:CteCto.ID)<BR>Asigna(Info.Nombre, CteCto:CteCto.Nombre)

[Acciones.Mensajes]
Nombre=Mensajes
Boton=112
NombreDesplegar=&Mensajes
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OutlookCteCto
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CteCto:CteCto.ID)
AntesExpresiones=Asigna(Info.ClienteContacto, CteCto:CteCto.ID)

[Ficha.CteCto.CFD_Enviar]
Carpeta=Ficha
Clave=CteCto.CFD_Enviar
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
[Ficha.CteCto.OPORTEnviar]
Carpeta=Ficha
Clave=CteCto.OPORTEnviar
Editar=S
3D=S
ColorFondo=Blanco

Tamano=25



LineaNueva=S



[Ficha.ListaEnCaptura]
(Inicio)=CteCto.Nombre
CteCto.Nombre=CteCto.ApellidoPaterno
CteCto.ApellidoPaterno=CteCto.ApellidoMaterno
CteCto.ApellidoMaterno=CteCto.eMail
CteCto.eMail=CteCto.CFD_Enviar
CteCto.CFD_Enviar=CteCto.OPORTEnviar
CteCto.OPORTEnviar=CteCto.Cargo
CteCto.Cargo=CteCto.Grupo
CteCto.Grupo=CteCto.Telefonos
CteCto.Telefonos=CteCto.Extencion
CteCto.Extencion=CteCto.Fax
CteCto.Fax=CteCto.PedirTono
CteCto.PedirTono=CteCto.EnviarA
CteCto.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteCto.FechaNacimiento
CteCto.FechaNacimiento=CteCto.Sexo
CteCto.Sexo=CteCto.Tipo
CteCto.Tipo=CteCto.Tratamiento
CteCto.Tratamiento=CteCto.Atencion
CteCto.Atencion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NombreCompleto
NombreCompleto=CteCto.eMail
CteCto.eMail=(Fin)

[Lista.ListaOrden]
(Inicio)=CteCto.Nombre<TAB>(Acendente)
CteCto.Nombre<TAB>(Acendente)=CteCto.ApellidoPaterno<TAB>(Acendente)
CteCto.ApellidoPaterno<TAB>(Acendente)=CteCto.ApellidoMaterno<TAB>(Acendente)
CteCto.ApellidoMaterno<TAB>(Acendente)=(Fin)











[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Comites
Comites=Actividades
Actividades=Direcciones
Direcciones=Eventos
Eventos=Anexos
Anexos=Mensajes
Mensajes=Cargo
Cargo=Historico
Historico=Grupos
Grupos=Navegador
Navegador=(Fin)
