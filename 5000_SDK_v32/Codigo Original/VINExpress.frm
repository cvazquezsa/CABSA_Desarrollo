[Forma]
Clave=VINExpress
Nombre=VIN Nuevo
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=184
PosicionInicialArriba=141
PosicionInicialAltura=450
PosicionInicialAncho=655
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaBloquearAjuste=N
IniciarAgregando=S
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.SerieLote, Nulo)
PosicionInicialAlturaCliente=452

[Detalle]
Estilo=Ficha
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
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
Pestana=S
PestanaOtroNombre=S

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
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S
Efectos=[Negritas]

[Detalle.Art.Descripcion1]
Carpeta=Detalle
Clave=Art.Descripcion1
Editar=N
3D=S
Tamano=41
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
Tamano=25
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

[Detalle.VIN.Aseguradora]
Carpeta=Detalle
Clave=VIN.Aseguradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

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

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
ValidaNombre=N
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
3D=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN) y (SQL(<T>SELECT VIN FROM VIN WHERE VIN=:tVIN<T>, VIN:VIN.VIN)<>VIN:VIN.VIN)
EjecucionMensaje=Si(ConDatos(VIN:VIN.VIN), <T>El Número Indicado, Ya Existe<T>, <T>Falta Indicar el Número<T>)
AntesExpresiones=Asigna(Info.SerieLote, VIN:VIN.VIN)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Cambios]
Nombre=Cambios
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

[Detalle.VIN.Placas]
Carpeta=Detalle
Clave=VIN.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.VIN.Poliza]
Carpeta=Detalle
Clave=VIN.Poliza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.PolizaTipo]
Carpeta=Detalle
Clave=VIN.PolizaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.PolizaVencimiento]
Carpeta=Detalle
Clave=VIN.PolizaVencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Codigos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Códigos
Clave=Codigos
PermiteEditar=S
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
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

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
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

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

[Detalle.VIN.FechaCartaCredito]
Carpeta=Detalle
Clave=VIN.FechaCartaCredito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Tasa]
Carpeta=Detalle
Clave=VIN.Tasa
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.FechaFactura]
Carpeta=Detalle
Clave=VIN.FechaFactura
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.FechaUltimoServicio]
Carpeta=Detalle
Clave=VIN.FechaUltimoServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.Registro]
Carpeta=Detalle
Clave=VIN.Registro
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.PolizaImporte]
Carpeta=Detalle
Clave=VIN.PolizaImporte
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.FordOasis]
Nombre=FordOasis
Boton=106
NombreDesplegar=&Oasis
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
NombreEnBoton=S
Expresion=URL(<T>http://www.fordmexico.com.mx/oasis/index.asp?distribuidora=<T>+General.FordDistribuidor+<T>&mercado=<T>+General.FordMercado+<T>&vin=<T>+VIN:VIN.VIN)
Activo=S
EjecucionCondicion=ConDatos(VIN:VIN.VIN)
VisibleCondicion=General.Ford

[Detalle.VIN.NumeroEconomico]
Carpeta=Detalle
Clave=VIN.NumeroEconomico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.VIN.TipoUnidad]
Carpeta=Detalle
Clave=VIN.TipoUnidad
Editar=S
ValidaNombre=S
3D=S
Tamano=14
ColorFuente=Negro
Pegado=S
Efectos=[Negritas]
ColorFondo=Blanco

[Detalle.VIN.Holograma]
Carpeta=Detalle
Clave=VIN.Holograma
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

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

[Forma.ListaCarpetas]
(Inicio)=Detalle
Detalle=Codigos
Codigos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=FordOasis
FordOasis=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=VIN.VIN
VIN.VIN=VIN.Modelo
VIN.Modelo=VIN.TipoUnidad
VIN.TipoUnidad=VIN.Articulo
VIN.Articulo=Art.Descripcion1
Art.Descripcion1=VIN.Motor
VIN.Motor=VIN.Placas
VIN.Placas=VIN.Llave
VIN.Llave=VIN.ClaveVehicular
VIN.ClaveVehicular=VIN.Registro
VIN.Registro=VIN.Aduana
VIN.Aduana=VIN.Pedimento
VIN.Pedimento=VIN.FechaCartaCredito
VIN.FechaCartaCredito=VIN.Tasa
VIN.Tasa=VIN.FechaFactura
VIN.FechaFactura=VIN.FechaUltimoServicio
VIN.FechaUltimoServicio=VIN.Aseguradora
VIN.Aseguradora=VIN.Poliza
VIN.Poliza=VIN.PolizaVencimiento
VIN.PolizaVencimiento=VIN.PolizaTipo
VIN.PolizaTipo=VIN.PolizaImporte
VIN.PolizaImporte=VIN.NumeroEconomico
VIN.NumeroEconomico=VIN.Holograma
VIN.Holograma=VIN.Cliente
VIN.Cliente=Cte.Nombre
Cte.Nombre=(Fin)

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
