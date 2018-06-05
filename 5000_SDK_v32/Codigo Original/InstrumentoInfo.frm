[Forma]
Clave=InstrumentoInfo
Nombre=Información del Instrumento
Icono=6
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=283
PosicionInicialArriba=251
PosicionInicialAltura=266
PosicionInicialAncho=457
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Instrumento
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Instrumento.Instrumento=<T>{Info.Instrumento}<T>

[Ficha.Instrumento.Instrumento]
Carpeta=Ficha
Clave=Instrumento.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Instrumento.Descripcion]
Carpeta=Ficha
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Ficha.Instrumento.Moneda]
Carpeta=Ficha
Clave=Instrumento.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Instrumento.RequiereBeneficiario]
Carpeta=Ficha
Clave=Instrumento.RequiereBeneficiario
Editar=S
LineaNueva=S
3D=S
Tamano=20
EspacioPrevio=S

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

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información de la Cuenta
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.CtaDinero, Instrumento:Instrumento.CtaDinero)
Visible=S

[Ficha.Instrumento.CtaDineroVenta]
Carpeta=Ficha
Clave=Instrumento.CtaDineroVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
EspacioPrevio=S

[Ficha.Instrumento.CtaDineroCompra]
Carpeta=Ficha
Clave=Instrumento.CtaDineroCompra
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Instrumento.FormaPagoVenta]
Carpeta=Ficha
Clave=Instrumento.FormaPagoVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Ficha.Instrumento.FormaPagoCompra]
Carpeta=Ficha
Clave=Instrumento.FormaPagoCompra
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=CtaDineroInfo
CtaDineroInfo=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Instrumento.Instrumento
Instrumento.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=Instrumento.Moneda
Instrumento.Moneda=Instrumento.CtaDineroVenta
Instrumento.CtaDineroVenta=Instrumento.CtaDineroCompra
Instrumento.CtaDineroCompra=Instrumento.FormaPagoVenta
Instrumento.FormaPagoVenta=Instrumento.FormaPagoCompra
Instrumento.FormaPagoCompra=Instrumento.RequiereBeneficiario
Instrumento.RequiereBeneficiario=(Fin)
