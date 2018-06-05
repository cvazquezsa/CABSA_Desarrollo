[Forma]
Clave=MovPos
Nombre=<T>Posición del Movimiento<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Origen
PosicionInicialIzquierda=201
PosicionInicialArriba=236
PosicionInicialAltura=289
PosicionInicialAncho=622
PosicionColumna1=50
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Modulo.Nombre(Info.Modulo),Info.Mov+<T> <T>+Info.MovID)
PosicionSeccion1=16
PosicionColumna2=50
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=262
PosicionCol1=309

[Origen]
Estilo=Iconos
Clave=Origen
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=MovFlujoO
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Origen
MenuLocal=S
ListaAcciones=(Lista)
ListaEnCaptura=Nombre
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Origenes<T>
OtroOrden=S
ListaOrden=(Lista)
IconosNombre=MovFlujoO:OMov+<T> <T>+Si(ConDatos(MovFlujoO:OMovID) y (MovFlujoO:OMovID<><T>0<T>), MovFlujoO:OMovID)+Si(MovFlujoO:Cancelado,<T>*<T>)

[Destino]
Estilo=Iconos
Clave=Destino
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A2
Vista=MovFlujoD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimientos Generados<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Movimiento(s) Generados
MenuLocal=S
ListaAcciones=(Lista)
ListaEnCaptura=Nombre
OtroOrden=S
ListaOrden=(Lista)
IconosNombre=MovFlujoD:DMov+<T> <T>+Si(ConDatos(MovFlujoD:DMovID) y (MovFlujoD:DMovID<><T>0<T>), MovFlujoD:DMovID)+Si(MovFlujoD:Cancelado, <T>*<T>)

[Origen.Columnas]
0=146
1=135

[Destino.Columnas]
0=149
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

[Acciones.ExaminarO]
Nombre=ExaminarO
Boton=0
NombreDesplegar=&Examinar
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Anuncio, SQL(<T>EXEC spPosicionMovimiento :tModulo, :nID<T>, MovFlujoO:OModulo, MovFlujoO:OID))<BR>ReportePantalla(Info.Anuncio, MovFlujoO:OID)
ActivoCondicion=ConDatos(MovFlujoO:OID) y Usuario.PreliminarMovs

[Acciones.ExaminarD]
Nombre=ExaminarD
Boton=0
NombreDesplegar=&Examinar
EnMenu=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Asigna(Info.Anuncio, SQL(<T>EXEC spPosicionMovimiento :tModulo, :nID<T>, MovFlujoD:DModulo, MovFlujoD:DID))<BR>ReportePantalla(Info.Anuncio, MovFlujoD:DID)
ActivoCondicion=ConDatos(MovFlujoD:DID) y Usuario.PreliminarMovs

[Destino.Nombre]
Carpeta=Destino
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Origen.Nombre]
Carpeta=Origen
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.IrO]
Nombre=IrO
Boton=0
NombreDesplegar=&Retroceder
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
ActivoCondicion=ConDatos(MovFlujoO:OID)
AntesExpresiones=Asigna(Info.Modulo, MovFlujoO:OModulo)<BR>Asigna(Info.ID, MovFlujoO:OID)<BR>Asigna(Info.Mov, MovFlujoO:OMov)<BR>Asigna(Info.MovID, MovFlujoO:OMovID)

[Acciones.IrD]
Nombre=IrD
Boton=0
NombreDesplegar=&Avanzar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
ActivoCondicion=ConDatos(MovFlujoD:DID)
AntesExpresiones=Asigna(Info.Modulo, MovFlujoD:DModulo) <BR>Asigna(Info.ID, MovFlujoD:DID)<BR>Asigna(Info.Mov, MovFlujoD:DMov)<BR>Asigna(Info.MovID, MovFlujoD:DMovID)

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S

[Acciones.Reporte]
Nombre=Reporte
Boton=68
NombreDesplegar=Reporte
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=VerMovFlujo
Activo=S
Visible=S

[Acciones.Retroceder]
Nombre=Retroceder
Boton=24
NombreDesplegar=Retroceder
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovFlujoO:OID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, MovFlujoO:OModulo)<BR>Asigna(Info.ID, MovFlujoO:OID)<BR>Asigna(Info.Mov, MovFlujoO:OMov)<BR>Asigna(Info.MovID, MovFlujoO:OMovID)
Visible=S

[Acciones.Avanzar]
Nombre=Avanzar
Boton=25
NombreDesplegar=Avanzar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovFlujoD:DID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, MovFlujoD:DModulo) <BR>Asigna(Info.ID, MovFlujoD:DID)<BR>Asigna(Info.Mov, MovFlujoD:DMov)<BR>Asigna(Info.MovID, MovFlujoD:DMovID)
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=ConDatos(Info.ID)

[Forma.ListaCarpetas]
(Inicio)=Origen
Origen=Destino
Destino=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Retroceder
Retroceder=Avanzar
Avanzar=Propiedades
Propiedades=Reporte
Reporte=(Fin)

[Origen.ListaAcciones]
(Inicio)=IrO
IrO=ExaminarO
ExaminarO=(Fin)

[Origen.ListaOrden]
(Inicio)=Cancelado<TAB>(Decendente)
Cancelado<TAB>(Decendente)=OModulo<TAB>(Acendente)
OModulo<TAB>(Acendente)=OID<TAB>(Acendente)
OID<TAB>(Acendente)=(Fin)

[Destino.ListaAcciones]
(Inicio)=IrD
IrD=ExaminarD
ExaminarD=(Fin)

[Destino.ListaOrden]
(Inicio)=Cancelado<TAB>(Decendente)
Cancelado<TAB>(Decendente)=DModulo<TAB>(Acendente)
DModulo<TAB>(Acendente)=DID<TAB>(Acendente)
DID<TAB>(Acendente)=(Fin)
