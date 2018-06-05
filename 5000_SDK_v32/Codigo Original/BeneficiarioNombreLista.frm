[Forma]
Clave=BeneficiarioNombreLista
Nombre=Beneficiarios
Icono=44
Modulos=DIN
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=478
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=324
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
VentanaEscCerrar=S
VentanaExclusiva=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BeneficiarioNombre
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarColumnas=
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=BeneficiarioNombre.Beneficiario
CarpetaVisible=S
PermiteEditar=S
HojaConfirmarEliminar=S
HojaTitulos=
HojaMantenerSeleccion=S

[Lista.BeneficiarioNombre.Beneficiario]
Carpeta=Lista
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Lista.Columnas]
Beneficiario=277
ImporteOmision=100
ConceptoOmision=173

[Detalle.BeneficiarioNombre.Beneficiario]
Carpeta=Detalle
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.BeneficiarioNombre.ImporteOmision]
Carpeta=Detalle
Clave=BeneficiarioNombre.ImporteOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=N

[Detalle.BeneficiarioNombre.ConceptoOmision]
Carpeta=Detalle
Clave=BeneficiarioNombre.ConceptoOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Visible=S
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Copiar, Verdadero)<BR>Asigna(Info.Importe, BeneficiarioNombre:BeneficiarioNombre.ImporteOmision)

[Detalles]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BeneficiarioNombre
Fuente={MS Sans Serif, 8, Negro, []}
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

[Detalles.BeneficiarioNombre.Beneficiario]
Carpeta=Detalles
Clave=BeneficiarioNombre.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40

[Detalles.BeneficiarioNombre.ImporteOmision]
Carpeta=Detalles
Clave=BeneficiarioNombre.ImporteOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=BeneficiarioNombre.Beneficiario
BeneficiarioNombre.Beneficiario=BeneficiarioNombre.ImporteOmision
BeneficiarioNombre.ImporteOmision=(Fin)
