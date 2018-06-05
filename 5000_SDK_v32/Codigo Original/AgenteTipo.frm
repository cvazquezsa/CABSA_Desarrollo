[Forma]
Clave=AgenteTipo
Nombre=Tipos Agentes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=523
PosicionInicialArriba=286
PosicionInicialAlturaCliente=425
PosicionInicialAncho=234
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgenteTipo
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
OtroOrden=S
ListaOrden=AgenteTipo.Orden<TAB>(Acendente)

[Lista.AgenteTipo.Tipo]
Carpeta=Lista
Clave=AgenteTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AgenteTipo.Orden]
Carpeta=Lista
Clave=AgenteTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=165
Orden=38

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

[Acciones.CampoExtra]
Nombre=CampoExtra
Boton=104
NombreEnBoton=S
NombreDesplegar=&Campos Extra
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtoTipoCampoExtra
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(AgenteTipo:AgenteTipo.Tipo)
AntesExpresiones=Asigna(Info.Tipo, <T>Agente<T>)<BR>Asigna(Info.SubTipo, AgenteTipo:AgenteTipo.Tipo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CampoExtra
CampoExtra=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=AgenteTipo.Tipo
AgenteTipo.Tipo=AgenteTipo.Orden
AgenteTipo.Orden=(Fin)
