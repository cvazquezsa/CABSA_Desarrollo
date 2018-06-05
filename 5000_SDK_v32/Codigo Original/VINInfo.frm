[Forma]
Clave=VINInfo
Nombre=Información del VIN
Icono=4
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=254
PosicionInicialArriba=226
PosicionInicialAltura=471
PosicionInicialAncho=772
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Menus=S
VentanaBloquearAjuste=N
PosicionInicialAlturaCliente=545
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)
ExpresionesAlCerrar=Asigna(Filtro.Articulo, Nulo)<BR>Asigna(Filtro.Proyecto, Nulo)<BR>Asigna(Filtro.Actividad, Nulo)
MovModulo=AUTO
BarraAyuda=S
BarraAyudaBold=S
Comentarios=Info.VIN
MenuPrincipal=(Lista)

[Lista.VIN.VIN]
Carpeta=Lista
Clave=VIN.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VIN.Articulo]
Carpeta=Lista
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
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
CondicionEdicion=no VIN:VIN.TieneMovimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=VIN.VIN=<T>{Info.VIN}<T>

[Detalle.VIN.VIN]
Carpeta=Detalle
Clave=VIN.VIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Articulo]
Carpeta=Detalle
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
Efectos=[Negritas]

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Detalle.VIN.Motor]
Carpeta=Detalle
Clave=VIN.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Llave]
Carpeta=Detalle
Clave=VIN.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Aduana]
Carpeta=Detalle
Clave=VIN.Aduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.VIN.Pedimento]
Carpeta=Detalle
Clave=VIN.Pedimento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.ClaveVehicular]
Carpeta=Detalle
Clave=VIN.ClaveVehicular
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Cliente]
Carpeta=Detalle
Clave=VIN.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EspacioPrevio=N
EditarConBloqueo=S

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
ValidaNombre=N
Tamano=44
ColorFondo=Plata
ColorFuente=Negro
3D=S

[Lista.Columnas]
VIN=152
Articulo=149
Descripcion1=204
Cliente_1=64
Cliente=70

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Lista.VIN.Cliente]
Carpeta=Lista
Clave=VIN.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Informacion]
Nombre=Informacion
Boton=34
Menu=&Ver
NombreDesplegar=Información
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=SerieLoteInfo
ConCondicion=S
Antes=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN) y ConDatos(VIN:VIN.Articulo)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)<BR>Asigna(Info.Articulo, VIN:VIN.Articulo)<BR>Asigna(Info.SubCuenta, <T><T>)<BR>Asigna(Info.ArtTipo, TipoVIN)

[Acciones.Anexo]
Nombre=Anexo
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.Rama, <T>VIN<T>)<BR>Asigna(Info.AnexoCfg, Falso)<BR>Asigna(Info.Cuenta, VIN:VIN.VIN)<BR>Asigna(Info.Descripcion, VIN:Art.Descripcion1+<T> (<T>+VIN:VIN.Articulo+<T>)<T>)

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Ver
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=VerDocumentacion(<T>VIN<T>, VIN:VIN.VIN, <T>Documentación - <T>+VIN:VIN.VIN)
EjecucionCondicion=ConDatos(VIN:VIN.VIN)

[Codigos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Códigos
Clave=Codigos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Codigos.VIN.VIN]
Carpeta=Codigos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Codigos.VIN.CodigoRadio]
Carpeta=Codigos
Clave=VIN.CodigoRadio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Codigos.VIN.CodigoTransmision]
Carpeta=Codigos
Clave=VIN.CodigoTransmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoColor]
Carpeta=Codigos
Clave=VIN.CodigoColor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta1]
Carpeta=Codigos
Clave=VIN.CodigoLlanta1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Codigos.VIN.CodigoLlanta2]
Carpeta=Codigos
Clave=VIN.CodigoLlanta2
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta3]
Carpeta=Codigos
Clave=VIN.CodigoLlanta3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta4]
Carpeta=Codigos
Clave=VIN.CodigoLlanta4
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos.VIN.CodigoLlanta5]
Carpeta=Codigos
Clave=VIN.CodigoLlanta5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Placas]
Carpeta=Detalle
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[(Carpeta Abrir).VIN.Articulo]
Carpeta=(Carpeta Abrir)
Clave=VIN.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).VIN.Fecha]
Carpeta=(Carpeta Abrir)
Clave=VIN.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=134
1=92

[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=&Actualizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Actualizar Arbol
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=&Presentacion preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Detalle.VIN.Registro]
Carpeta=Detalle
Clave=VIN.Registro
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.VIN.FechaCartaCredito]
Carpeta=Detalle
Clave=VIN.FechaCartaCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.FechaFactura]
Carpeta=Detalle
Clave=VIN.FechaFactura
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.VIN.FechaUltimoServicio]
Carpeta=Detalle
Clave=VIN.FechaUltimoServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Tasa]
Carpeta=Detalle
Clave=VIN.Tasa
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S
Pegado=S

[Acciones.Otros1]
Nombre=Otros1
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros2]
Nombre=Otros2
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros3]
Nombre=Otros3
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros4]
Nombre=Otros4
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros5]
Nombre=Otros5
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros6]
Nombre=Otros6
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros7]
Nombre=Otros7
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros8]
Nombre=Otros8
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Otros9]
Nombre=Otros9
Menu=&Otros
EnMenu=S
TipoAccion=Expresion

[Acciones.Accesorios]
Nombre=Accesorios
Boton=47
Menu=&Ver
NombreDesplegar=&Componentes
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
Antes=S
GuardarAntes=S
DespuesGuardar=S
UsaTeclaRapida=S
TeclaRapida=F7
NombreEnBoton=S
EspacioPrevio=S
Expresion=Asigna(Info.Bloqueado, Verdadero)<BR>Si(Si(Config.VINAccesorioArt, Forma(<T>VINAccesorioArt<T>), Forma(<T>VINAccesorio<T>)),  Forma.ActualizarForma)
ActivoCondicion=Usuario.Costos
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.VIN, VIN:VIN.VIN)<BR>Asigna(Info.Bloqueado, Falso)

[Detalle.VIN.Km]
Carpeta=Detalle
Clave=VIN.Km
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Cambio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Unidad a Cambio
Clave=Cambio
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
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

[Cambio.VIN.CambioVIN]
Carpeta=Cambio
Clave=VIN.CambioVIN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Cambio.VIN.CambioKm]
Carpeta=Cambio
Clave=VIN.CambioKm
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Conductor]
Carpeta=Detalle
Clave=VIN.Conductor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
EditarConBloqueo=S

[Detalle.CteDestino.Nombre]
Carpeta=Detalle
Clave=CteDestino.Nombre
Editar=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Historico]
Nombre=Historico
Boton=53
Menu=&Ver
NombreDesplegar=Histórico del Cambios
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=VINHist
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)

[Detalle.VIN.FechaSiguienteServicio]
Carpeta=Detalle
Clave=VIN.FechaSiguienteServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Venta]
Nombre=Venta
Boton=57
Menu=&Ver
NombreDesplegar=&Venta
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Reportes Pantalla
ClaveAccion=VTAS
ListaParametros1=VIN:VIN.VentaID
ListaParametros=S
Visible=S
EspacioPrevio=S
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(VIN:VIN.VentaID)

[Acciones.FordOasis]
Nombre=FordOasis
Boton=106
Menu=&Ver
NombreDesplegar=&Oasis
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConCondicion=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+O
Expresion=URL(<T>http://www.fordmexico.com.mx/oasis/index.asp?distribuidora=<T>+General.FordDistribuidor+<T>&mercado=<T>+General.FordMercado+<T>&vin=<T>+VIN:VIN.VIN)
ActivoCondicion=General.Ford
EjecucionCondicion=ConDatos(VIN:VIN.VIN)

[Detalle.VIN.NumeroEconomico]
Carpeta=Detalle
Clave=VIN.NumeroEconomico
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
EspacioPrevio=S
EditarConBloqueo=N
Efectos=[Negritas]

[Fechas]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fechas
Clave=Fechas
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Fechas.VIN.VIN]
Carpeta=Fechas
Clave=VIN.VIN
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.FechaEntrada]
Carpeta=Fechas
Clave=VIN.FechaEntrada
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.FechaSalida]
Carpeta=Fechas
Clave=VIN.FechaSalida
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.Dias]
Carpeta=Fechas
Clave=Dias
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.CostoPiso]
Nombre=CostoPiso
Boton=64
Menu=&Ver
NombreDesplegar=&Costo Piso
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
ConCondicion=S
Antes=S
EspacioPrevio=S
UsaTeclaRapida=S
TeclaRapida=F7
ClaveAccion=VINCostoPiso
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)

[Detalle.VIN.TipoUnidad]
Carpeta=Detalle
Clave=VIN.TipoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S
Efectos=[Negritas]

[Detalle.VIN.Holograma]
Carpeta=Detalle
Clave=VIN.Holograma
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Fechas.VIN.FechaMRS]
Carpeta=Fechas
Clave=VIN.FechaMRS
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Modelo]
Carpeta=Detalle
Clave=VIN.Modelo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[FordDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford (Otros Datos)
Clave=FordDatos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionEdicion=no VIN:VIN.Interfase
CondicionVisible=General.Ford

[FordDatos.VIN.VIN]
Carpeta=FordDatos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FordDatos.VIN.PrecioBasicoDistribuidor]
Carpeta=FordDatos
Clave=VIN.PrecioBasicoDistribuidor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[FordDatos.VIN.PrecioBasicoPublico]
Carpeta=FordDatos
Clave=VIN.PrecioBasicoPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.AjusteBasicoDistribuidor]
Carpeta=FordDatos
Clave=VIN.AjusteBasicoDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.TotalAccesoriosDistribuidor]
Carpeta=FordDatos
Clave=VIN.TotalAccesoriosDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordDatos.VIN.TotalAccesoriosPublico]
Carpeta=FordDatos
Clave=VIN.TotalAccesoriosPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalDescuentoAccesoriosMemo]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoAccesoriosMemo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.TotalDescuentoDistribuidorMemo]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoDistribuidorMemo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalDescuentoPepPublico]
Carpeta=FordDatos
Clave=VIN.TotalDescuentoPepPublico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento1Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento1Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.Descuento1Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento1Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento1Publico]
Carpeta=FordDatos
Clave=VIN.Descuento1Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento2Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento2Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento2Publico]
Carpeta=FordDatos
Clave=VIN.Descuento2Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento3Descripcion]
Carpeta=FordDatos
Clave=VIN.Descuento3Descripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.Descuento3Distribuidor]
Carpeta=FordDatos
Clave=VIN.Descuento3Distribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Descuento3Publico]
Carpeta=FordDatos
Clave=VIN.Descuento3Publico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SeguroProvincial]
Carpeta=FordDatos
Clave=VIN.SeguroProvincial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[FordDatos.VIN.GastosTraslado]
Carpeta=FordDatos
Clave=VIN.GastosTraslado
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SeguroAsociacion]
Carpeta=FordDatos
Clave=VIN.SeguroAsociacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Bonificacion15DiasSinIntereses]
Carpeta=FordDatos
Clave=VIN.Bonificacion15DiasSinIntereses
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.ReembolsoTransportacion]
Carpeta=FordDatos
Clave=VIN.ReembolsoTransportacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Bonificacion]
Carpeta=FordDatos
Clave=VIN.Bonificacion
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.BonificacionEnPrecio]
Carpeta=FordDatos
Clave=VIN.BonificacionEnPrecio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.GarantiaServicio]
Carpeta=FordDatos
Clave=VIN.GarantiaServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.Miscelaneos]
Carpeta=FordDatos
Clave=VIN.Miscelaneos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.SubTotalFacturaCompra]
Carpeta=FordDatos
Clave=VIN.SubTotalFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.IVAFacturaCompra]
Carpeta=FordDatos
Clave=VIN.IVAFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordDatos.VIN.CoutaPublicidad]
Carpeta=FordDatos
Clave=VIN.CoutaPublicidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.TotalFacturaCompra]
Carpeta=FordDatos
Clave=VIN.TotalFacturaCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[FordDatos.VIN.NivelPrecios]
Carpeta=FordDatos
Clave=VIN.NivelPrecios
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordDatos.VIN.CoutaFondoCivico]
Carpeta=FordDatos
Clave=VIN.CoutaFondoCivico
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordDatos.VIN.CoutaFordStar]
Carpeta=FordDatos
Clave=VIN.CoutaFordStar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ford (Datos Generales)
Clave=FordGenerales
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CondicionEdicion=no VIN:VIN.Interfase
ListaEnCaptura=(Lista)
CondicionVisible=General.Ford

[FordGenerales.VIN.VIN]
Carpeta=FordGenerales
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[FordGenerales.VIN.Modelo]
Carpeta=FordGenerales
Clave=VIN.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveFinanciera]
Carpeta=FordGenerales
Clave=VIN.ClaveFinanciera
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.NumeroOrden]
Carpeta=FordGenerales
Clave=VIN.NumeroOrden
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.TipoCompra]
Carpeta=FordGenerales
Clave=VIN.TipoCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.FolioFacturaCompra]
Carpeta=FordGenerales
Clave=VIN.FolioFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.FechaFacturaCompra]
Carpeta=FordGenerales
Clave=VIN.FechaFacturaCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.Mercado]
Carpeta=FordGenerales
Clave=VIN.Mercado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveDistribuidor]
Carpeta=FordGenerales
Clave=VIN.ClaveDistribuidor
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.Descripcion1]
Carpeta=FordGenerales
Clave=VIN.Descripcion1
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[FordGenerales.VIN.Descripcion2]
Carpeta=FordGenerales
Clave=VIN.Descripcion2
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ColorExterior]
Carpeta=FordGenerales
Clave=VIN.ColorExterior
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S

[FordGenerales.VIN.ColorExteriorDescripcion]
Carpeta=FordGenerales
Clave=VIN.ColorExteriorDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ColorInterior]
Carpeta=FordGenerales
Clave=VIN.ColorInterior
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[FordGenerales.VIN.ColorInteriorDescripcion]
Carpeta=FordGenerales
Clave=VIN.ColorInteriorDescripcion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.ClaveAduana]
Carpeta=FordGenerales
Clave=VIN.ClaveAduana
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[FordGenerales.VIN.PedimentoFecha]
Carpeta=FordGenerales
Clave=VIN.PedimentoFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[FordGenerales.VIN.OtrasOpciones]
Carpeta=FordGenerales
Clave=VIN.OtrasOpciones
Editar=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Fechas.VIN.DiasLibresIntereses]
Carpeta=Fechas
Clave=VIN.DiasLibresIntereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Fechas.FechaInicioCostoPiso]
Carpeta=Fechas
Clave=FechaInicioCostoPiso
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Fechas.VIN.UltimoPagoCostoPiso]
Carpeta=Fechas
Clave=VIN.UltimoPagoCostoPiso
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.GarantiaVencimiento]
Carpeta=Detalle
Clave=VIN.GarantiaVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[Fechas.VIN.IntercambioDirecto]
Carpeta=Fechas
Clave=VIN.IntercambioDirecto
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.VIN.FechaImportacion]
Carpeta=Detalle
Clave=VIN.FechaImportacion
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
ValidaNombre=S

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[OtrosDatos.VIN.VIN]
Carpeta=OtrosDatos
Clave=VIN.VIN
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.VIN.ColorExterior]
Carpeta=OtrosDatos
Clave=VIN.ColorExterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorExteriorDescripcion]
Carpeta=OtrosDatos
Clave=VIN.ColorExteriorDescripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorInterior]
Carpeta=OtrosDatos
Clave=VIN.ColorInterior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.VIN.ColorInteriorDescripcion]
Carpeta=OtrosDatos
Clave=VIN.ColorInteriorDescripcion
Editar=S
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Precios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Precios
Clave=Precios
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VIN
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=Usuario.Costos y Config.VINCostoSumaAccesorios

[Precios.VIN.PrecioDistribuidor]
Carpeta=Precios
Clave=VIN.PrecioDistribuidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.PrecioPublico]
Carpeta=Precios
Clave=VIN.PrecioPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Tamano=20

[Precios.VIN.ISANPublico]
Carpeta=Precios
Clave=VIN.ISANPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.IVAPublico]
Carpeta=Precios
Clave=VIN.IVAPublico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.PrecioPublicoTotal]
Carpeta=Precios
Clave=PrecioPublicoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Precios.VIN.PrecioContado]
Carpeta=Precios
Clave=VIN.PrecioContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Tamano=20

[Precios.VIN.ISANContado]
Carpeta=Precios
Clave=VIN.ISANContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.VIN.IVAContado]
Carpeta=Precios
Clave=VIN.IVAContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Precios.PrecioContadoTotal]
Carpeta=Precios
Clave=PrecioContadoTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20
Efectos=[Negritas]

[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Precios
Precios=Fechas
Fechas=Codigos
Codigos=FordGenerales
FordGenerales=FordDatos
FordDatos=OtrosDatos
OtrosDatos=Cambio
Cambio=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Accesorios
Accesorios=Anexo
Anexo=Doc
Doc=Informacion
Informacion=CostoPiso
CostoPiso=Historico
Historico=Venta
Venta=FordOasis
FordOasis=Otros1
Otros1=Otros2
Otros2=Otros3
Otros3=Otros4
Otros4=Otros5
Otros5=Otros6
Otros6=Otros7
Otros7=Otros8
Otros8=Otros9
Otros9=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=&Maestros
&Maestros=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Modelo
VIN.Modelo=VIN.TipoUnidad
VIN.TipoUnidad=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=VIN.Motor
VIN.Motor=VIN.Placas
VIN.Placas=VIN.Llave
VIN.Llave=VIN.Km
VIN.Km=VIN.ClaveVehicular
VIN.ClaveVehicular=VIN.Registro
VIN.Registro=VIN.Aduana
VIN.Aduana=VIN.Pedimento
VIN.Pedimento=VIN.FechaImportacion
VIN.FechaImportacion=VIN.FechaCartaCredito
VIN.FechaCartaCredito=VIN.Tasa
VIN.Tasa=VIN.FechaFactura
VIN.FechaFactura=VIN.FechaUltimoServicio
VIN.FechaUltimoServicio=VIN.FechaSiguienteServicio
VIN.FechaSiguienteServicio=VIN.GarantiaVencimiento
VIN.GarantiaVencimiento=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Holograma
VIN.Holograma=VIN.Cliente
VIN.Cliente=Cte.Nombre
Cte.Nombre=VIN.Conductor
VIN.Conductor=CteDestino.Nombre
CteDestino.Nombre=(Fin)

[Codigos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.CodigoRadio
VIN.CodigoRadio=VIN.CodigoTransmision
VIN.CodigoTransmision=VIN.CodigoColor
VIN.CodigoColor=VIN.CodigoLlanta1
VIN.CodigoLlanta1=VIN.CodigoLlanta2
VIN.CodigoLlanta2=VIN.CodigoLlanta3
VIN.CodigoLlanta3=VIN.CodigoLlanta4
VIN.CodigoLlanta4=VIN.CodigoLlanta5
VIN.CodigoLlanta5=(Fin)

[Cambio.ListaEnCaptura]
(Inicio)=VIN.CambioVIN
VIN.CambioVIN=VIN.CambioKm
VIN.CambioKm=(Fin)

[Fechas.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.FechaMRS
VIN.FechaMRS=VIN.FechaEntrada
VIN.FechaEntrada=VIN.FechaSalida
VIN.FechaSalida=Dias
Dias=VIN.DiasLibresIntereses
VIN.DiasLibresIntereses=FechaInicioCostoPiso
FechaInicioCostoPiso=VIN.UltimoPagoCostoPiso
VIN.UltimoPagoCostoPiso=VIN.IntercambioDirecto
VIN.IntercambioDirecto=(Fin)

[FordDatos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.PrecioBasicoDistribuidor
VIN.PrecioBasicoDistribuidor=VIN.PrecioBasicoPublico
VIN.PrecioBasicoPublico=VIN.AjusteBasicoDistribuidor
VIN.AjusteBasicoDistribuidor=VIN.TotalAccesoriosDistribuidor
VIN.TotalAccesoriosDistribuidor=VIN.TotalAccesoriosPublico
VIN.TotalAccesoriosPublico=VIN.TotalDescuentoAccesoriosMemo
VIN.TotalDescuentoAccesoriosMemo=VIN.TotalDescuentoDistribuidorMemo
VIN.TotalDescuentoDistribuidorMemo=VIN.TotalDescuentoPepPublico
VIN.TotalDescuentoPepPublico=VIN.Descuento1Descripcion
VIN.Descuento1Descripcion=VIN.Descuento1Distribuidor
VIN.Descuento1Distribuidor=VIN.Descuento1Publico
VIN.Descuento1Publico=VIN.Descuento2Descripcion
VIN.Descuento2Descripcion=VIN.Descuento2Distribuidor
VIN.Descuento2Distribuidor=VIN.Descuento2Publico
VIN.Descuento2Publico=VIN.Descuento3Descripcion
VIN.Descuento3Descripcion=VIN.Descuento3Distribuidor
VIN.Descuento3Distribuidor=VIN.Descuento3Publico
VIN.Descuento3Publico=VIN.SeguroProvincial
VIN.SeguroProvincial=VIN.GastosTraslado
VIN.GastosTraslado=VIN.SeguroAsociacion
VIN.SeguroAsociacion=VIN.Bonificacion15DiasSinIntereses
VIN.Bonificacion15DiasSinIntereses=VIN.ReembolsoTransportacion
VIN.ReembolsoTransportacion=VIN.Bonificacion
VIN.Bonificacion=VIN.BonificacionEnPrecio
VIN.BonificacionEnPrecio=VIN.GarantiaServicio
VIN.GarantiaServicio=VIN.Miscelaneos
VIN.Miscelaneos=VIN.SubTotalFacturaCompra
VIN.SubTotalFacturaCompra=VIN.IVAFacturaCompra
VIN.IVAFacturaCompra=VIN.CoutaPublicidad
VIN.CoutaPublicidad=VIN.CoutaFondoCivico
VIN.CoutaFondoCivico=VIN.CoutaFordStar
VIN.CoutaFordStar=VIN.TotalFacturaCompra
VIN.TotalFacturaCompra=VIN.NivelPrecios
VIN.NivelPrecios=(Fin)

[FordGenerales.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Modelo
VIN.Modelo=VIN.ClaveFinanciera
VIN.ClaveFinanciera=VIN.NumeroOrden
VIN.NumeroOrden=VIN.TipoCompra
VIN.TipoCompra=VIN.FolioFacturaCompra
VIN.FolioFacturaCompra=VIN.FechaFacturaCompra
VIN.FechaFacturaCompra=VIN.Mercado
VIN.Mercado=VIN.ClaveDistribuidor
VIN.ClaveDistribuidor=VIN.ColorExterior
VIN.ColorExterior=VIN.ColorExteriorDescripcion
VIN.ColorExteriorDescripcion=VIN.ColorInterior
VIN.ColorInterior=VIN.ColorInteriorDescripcion
VIN.ColorInteriorDescripcion=VIN.ClaveAduana
VIN.ClaveAduana=VIN.PedimentoFecha
VIN.PedimentoFecha=VIN.Descripcion1
VIN.Descripcion1=VIN.Descripcion2
VIN.Descripcion2=VIN.OtrasOpciones
VIN.OtrasOpciones=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.ColorExterior
VIN.ColorExterior=VIN.ColorExteriorDescripcion
VIN.ColorExteriorDescripcion=VIN.ColorInterior
VIN.ColorInterior=VIN.ColorInteriorDescripcion
VIN.ColorInteriorDescripcion=(Fin)

[Precios.ListaEnCaptura]
(Inicio)=VIN.PrecioDistribuidor
VIN.PrecioDistribuidor=VIN.PrecioPublico
VIN.PrecioPublico=VIN.ISANPublico
VIN.ISANPublico=VIN.IVAPublico
VIN.IVAPublico=PrecioPublicoTotal
PrecioPublicoTotal=VIN.PrecioContado
VIN.PrecioContado=VIN.ISANContado
VIN.ISANContado=VIN.IVAContado
VIN.IVAContado=PrecioContadoTotal
PrecioContadoTotal=(Fin)
