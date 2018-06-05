[Forma]
Clave=ProyD
Nombre=Personal Asignado
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Proyecto
PosicionInicialIzquierda=546
PosicionInicialArriba=380
PosicionInicialAlturaCliente=403
PosicionInicialAncho=836
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyD
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=ProyD.Proyecto=<T>{Info.Proyecto}<T>

[Lista.ProyD.Personal]
Carpeta=Lista
Clave=ProyD.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.FechaInicio]
Carpeta=Lista
Clave=ProyD.FechaInicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.FechaFin]
Carpeta=Lista
Clave=ProyD.FechaFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.Estatus]
Carpeta=Lista
Clave=ProyD.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
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

[Lista.Columnas]
Personal=86
FechaInicio=82
FechaFin=65
Estatus=61
Cliente=72
Proveedor=85
Agente=81
Nombre=147
Situacion=112

[Lista.ProyD.Cliente]
Carpeta=Lista
Clave=ProyD.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.Proveedor]
Carpeta=Lista
Clave=ProyD.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.Agente]
Carpeta=Lista
Clave=ProyD.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CteInfo]
Nombre=CteInfo
Boton=0
NombreDesplegar=Información del Cliente
EnMenu=S
TipoAccion=Formas
ClaveAccion=CteInfo
Antes=S
Visible=S
ActivoCondicion=ConDatos(ProyD:ProyD.Cliente)
AntesExpresiones=Asigna(Info.Cliente, ProyD:ProyD.Cliente)

[Acciones.PersonalInfo]
Nombre=PersonalInfo
Boton=0
NombreDesplegar=Información de la Persona
EnMenu=S
TipoAccion=Formas
ClaveAccion=PersonalInfo
ActivoCondicion=ConDatos(ProyD:ProyD.Personal)
Antes=S
AntesExpresiones=Asigna(Info.Personal, ProyD:ProyD.Personal)
Visible=S

[Acciones.ProvInfo]
Nombre=ProvInfo
Boton=0
NombreDesplegar=Información del Proveedor
EnMenu=S
TipoAccion=Formas
ClaveAccion=ProvInfo
ActivoCondicion=ConDatos(ProyD:ProyD.Proveedor)
Antes=S
AntesExpresiones=Asigna(Info.Proveedor, ProyD:ProyD.Proveedor)
Visible=S

[Acciones.AgenteInfo]
Nombre=AgenteInfo
Boton=0
NombreDesplegar=Información del Agente
EnMenu=S
TipoAccion=Formas
ClaveAccion=AgenteInfo
ActivoCondicion=ConDatos(ProyD:ProyD.Agente)
Antes=S
AntesExpresiones=Asigna(Info.Agente, ProyD:ProyD.Agente)
Visible=S

[Lista.ProyD.Nombre]
Carpeta=Lista
Clave=ProyD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyD.Situacion]
Carpeta=Lista
Clave=ProyD.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ProyD.Personal
ProyD.Personal=ProyD.Proveedor
ProyD.Proveedor=ProyD.Agente
ProyD.Agente=ProyD.Cliente
ProyD.Cliente=ProyD.Nombre
ProyD.Nombre=ProyD.Situacion
ProyD.Situacion=ProyD.FechaInicio
ProyD.FechaInicio=ProyD.FechaFin
ProyD.FechaFin=ProyD.Estatus
ProyD.Estatus=(Fin)

[Lista.ListaAcciones]
(Inicio)=PersonalInfo
PersonalInfo=CteInfo
CteInfo=ProvInfo
ProvInfo=AgenteInfo
AgenteInfo=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Personal.Nombre
Personal.Nombre=Personal.ApellidoPaterno
Personal.ApellidoPaterno=Cte.Nombre
Cte.Nombre=Prov.Nombre
Prov.Nombre=Agente.Nombre
Agente.Nombre=(Fin)
