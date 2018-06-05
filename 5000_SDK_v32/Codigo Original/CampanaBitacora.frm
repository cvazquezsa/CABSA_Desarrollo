[Forma]
Clave=CampanaBitacora
Nombre=Bitácora del Contacto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=526
PosicionInicialArriba=362
PosicionInicialAlturaCliente=440
PosicionInicialAncho=867
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Clave, Info.Nombre)  
VentanaExclusiva=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

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

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaEvento
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tipo Evento<T>
ElementosPorPagina=200
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
OtroOrden=S
IconosNombre=CampanaEvento:CampanaEvento.Tipo
ListaOrden=CampanaEvento.FechaHora<TAB>(Acendente)
FiltroGeneral=CampanaEvento.ID={Info.ID} AND CampanaEvento.RID={Info.RID}

[Lista.CampanaEvento.Observaciones]
Carpeta=Lista
Clave=CampanaEvento.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70x5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaEvento.FechaHora]
Carpeta=Lista
Clave=CampanaEvento.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=161
1=234

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.CampanaEvento.Situacion]
Carpeta=Lista
Clave=CampanaEvento.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaEvento.SituacionFecha]
Carpeta=Lista
Clave=CampanaEvento.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CampanaEvento.Observaciones
CampanaEvento.Observaciones=CampanaEvento.Situacion
CampanaEvento.Situacion=CampanaEvento.SituacionFecha
CampanaEvento.SituacionFecha=CampanaEvento.FechaHora
CampanaEvento.FechaHora=(Fin)
