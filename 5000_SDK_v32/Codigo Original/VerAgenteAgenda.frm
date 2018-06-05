[Forma]
Clave=VerAgenteAgenda
Nombre=Agenda
Icono=65
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Lista(FechaEnTexto(Info.Fecha, <T>dddd dd/mmm/aaaa<T>), Vacio(Info.Agente, <T>(Todos)<T>))
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=470
PosicionInicialAncho=437
ListaAcciones=(Lista)
PosicionInicialIzquierda=293
PosicionInicialArriba=132
VentanaEscCerrar=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=VerAgenteAgenda
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Hora<T>
ListaEnCaptura=(Lista)
IconosNombre=VerAgenteAgenda:Hora

[Lista.Columnas]
0=130
1=132

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

[Lista.Estatus]
Carpeta=Lista
Clave=Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Fecha]
Nombre=Fecha
Boton=53
NombreEnBoton=S
NombreDesplegar=&Fecha
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarFecha<T>)

[Acciones.Anterior]
Nombre=Anterior
Boton=24
NombreDesplegar=Día &Anterior
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Fecha, Info.Fecha-1)

[Acciones.Siguiente]
Nombre=Siguiente
Boton=25
NombreDesplegar=Día &Siguiente
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Fecha, Info.Fecha+1)
Visible=S

[Acciones.Agente]
Nombre=Agente
Boton=60
NombreEnBoton=S
NombreDesplegar=&Agente
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>EspecificarAgente<T>)

[Lista.Agente]
Carpeta=Lista
Clave=Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Anterior
Anterior=Siguiente
Siguiente=Fecha
Fecha=Agente
Agente=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Estatus
Estatus=Agente
Agente=(Fin)
