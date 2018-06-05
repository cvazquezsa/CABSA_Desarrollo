[Forma]
Clave=EnviarCorreo
Nombre=Enviar Correo (en Lotes) - SQL Mail
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=287
PosicionInicialAncho=741
IniciarAgregando=S
PosicionInicialIzquierda=269
PosicionInicialArriba=355
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
DialogoAbrir=S
Comentarios=Info.Nombre

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EnviarCorreo
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

[Ficha.EnviarCorreo.Fecha]
Carpeta=Ficha
Clave=EnviarCorreo.Fecha
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
IgnoraFlujo=S

[Ficha.EnviarCorreo.Asunto]
Carpeta=Ficha
Clave=EnviarCorreo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.EnviarCorreo.Mensaje]
Carpeta=Ficha
Clave=EnviarCorreo.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=102x10

[Ficha.EnviarCorreo.Anexos]
Carpeta=Ficha
Clave=EnviarCorreo.Anexos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=102
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Procesar]
Nombre=Procesar
Boton=84
NombreEnBoton=S
NombreDesplegar=&Seleccionar y Enviar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Caso Info.Nombre<BR>  Es <T>Clientes<T> Entonces <BR>    Si<BR>      Forma(<T>CteProcesar<T>)<BR>    Entonces<BR>      ProcesarSQL(<T>xpEnviarCorreoCte :nID, :nEstacion<T>, EnviarCorreo:EnviarCorreo.ID, EstacionTrabajo)<BR>    Fin<BR>  Es <T>Proveedores<T> Entonces<BR>    Si<BR>      Forma(<T>ProvProcesar<T>)<BR>    Entonces<BR>      ProcesarSQL(<T>xpEnviarCorreoProv :nID, :nEstacion<T>, EnviarCorreo:EnviarCorreo.ID, EstacionTrabajo)<BR>    Fin<BR>  Es <T>Agentes<T> Entonces <BR>    Si<BR>      Forma(<T>AgenteProcesar<T>)<BR>    Entonces<BR>      ProcesarSQL(<T>xpEnviarCorreoAgente :nID, :nEstacion<T>, EnviarCorreo:EnviarCorreo.ID, EstacionTrabajo)<BR>    Fin<BR>  Es <T>Personal<T> Entonces <BR>    Si<BR>      Forma(<T>PersonalProcesar<T>)<BR>    Entonces<BR>      ProcesarSQL(<T>xpEnviarCorreoPersonal :nID, :nEstacion, :tEmpresa<T>, EnviarCorreo:EnviarCorreo.ID, EstacionTrabajo,Empresa)<BR>    Fin<BR>  Es <T>Usuarios<T> Entonces <BR>    Si<BR>      Forma(<T>UsuarioProcesar<T>)<BR>    Entonces<BR>      ProcesarSQL(<T>xpEnviarCorreoUsuario :nID, :nEstacion<T>, EnviarCorreo:EnviarCorreo.ID, EstacionTrabajo)<BR>    Fin<BR>Fin
[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=Abrir...
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=EnviarCorreoA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Asunto<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EnviarCorreo.Fecha
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Mensajes
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=EnviarCorreo.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
IconosNombre=EnviarCorreoA:EnviarCorreo.Asunto
ListaAcciones=Personalizar

[(Carpeta Abrir).EnviarCorreo.Fecha]
Carpeta=(Carpeta Abrir)
Clave=EnviarCorreo.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=623
1=91

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Activo=S
Visible=S
EspacioPrevio=S

[Ficha.EnviarCorreo.Grupo]
Carpeta=Ficha
Clave=EnviarCorreo.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Ficha.ListaEnCaptura]
(Inicio)=EnviarCorreo.Asunto
EnviarCorreo.Asunto=EnviarCorreo.Fecha
EnviarCorreo.Fecha=EnviarCorreo.Grupo
EnviarCorreo.Grupo=EnviarCorreo.Mensaje
EnviarCorreo.Mensaje=EnviarCorreo.Anexos
EnviarCorreo.Anexos=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Eliminar
Eliminar=Procesar
Procesar=(Fin)
